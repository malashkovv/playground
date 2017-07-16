from pymongo import MongoClient
from datetime import datetime
from random import choice
from pprint import pprint

cities_list = [('New York', 'US'), ('Los Angeles', 'US'), ('Minsk', 'BY')]


def basic_crud():
    with MongoClient() as client:
        test_db = client.get_database('test')
        test_db.drop_collection('cities')
        cities = test_db.get_collection('cities')

        # insert/create
        for name, region in cities_list:
            cities.insert(dict(name=name, region=region, created=datetime.now()))

        # queries
        pprint(list(cities.find({'region': 'US'}, {'name': True})))
        pprint(list(cities.find({'region': {'$ne': 'US'}}, {'name': True})))
        pprint(list(cities.find({'$and': [{'region': 'US'}, {'name': {'$ne': 'Los Angeles'}}]})))
        pprint(cities.find_one({'region': 'US'}))

        # update
        cities.update_many({'region': 'US'}, {'$set': {'region': 'USA'}})
        pprint(list(cities.find()))

        # delete
        cities.remove({'region': 'US'})
        pprint(list(cities.find()))


def indexing_aggregating_mapreduce():
    with MongoClient() as client:
        test_db = client.get_database('test')
        test_db.drop_collection('clients')
        clients = test_db.get_collection('clients')

        # unique index
        clients.ensure_index('phone', unique=True, drop_dups=True, background=True)
        clients.insert_many([{'phone': str(i).zfill(7), 'region': choice(['USA', 'BY', 'AU'])} for i in range(0, 99999)])

        # search
        result = clients.find({'phone': '0012345'})
        pprint(result)
        pprint(result.explain())

        # aggregating
        pprint(clients.distinct('region'))
        pprint(clients.group({'region': 1}, {}, {"count": 0}, 'function(obj, prev){prev.count++;}'))
        pprint(list(clients.map_reduce(
            map="function () {emit(this.region, 1);}",
            reduce="function (key, values) {var total = 0; "
                   "for(i = 0; i < values.length; i++){ total += values[i];} return total;}",
            out='clients.report'
        ).find()))
        
# basic_crud()
indexing_aggregating_mapreduce()