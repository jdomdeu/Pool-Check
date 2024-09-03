# -*- coding: utf-8 -*-
#
# Copyright 2015 Telefonica Investigación y Desarrollo, S.A.U
#
# This file is part of Short Term Historic (FI-WARE project).
#
# iot-sth is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General
# Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any
# later version.
# iot-sth is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more
# details.
#
# You should have received a copy of the GNU Affero General Public License along with iot-sth. If not, see
# http://www.gnu.org/licenses/.
#
# For those usages not covered by the GNU Affero General Public License please contact:
# iot_support at tid.es
#
import time

__author__ = 'Iván Arias León (ivan.ariasleon at telefonica dot com)'

import string

from decimal import Decimal
from lettuce import world

import general_utils
from tools.fabric_utils import FabricSupport
from tools.notification_utils import Notifications
from tools import http_utils
from tools.remote_log_utils import Remote_Log

# constants
EMPTY              = u''
PROTOCOL           = u'protocol'
PROTOCOL_DEFAULT   = u'http'
HOST               = u'host'
PORT               = u'port'
STH_NOTIFICATION   = u'notify'
VERSION            = u'version'
VERIFY_VERSION     = u'verify_version'
FABRIC_USER        = u'fabric_user'
FABRIC_PASSWORD    = u'fabric_password'
FABRIC_CERT_FILE   = u'fabric_cert_file'
FABRIC_ERROR_RETRY = u'fabric_error_retry'
FABRIC_SOURCE_PATH = u'fabric_source_path'
FABRIC_TARGET_PATH = u'fabric_target_path'
FABRIC_SUDO        = u'fabric_sudo'
LOG_FILE           = u'log_file'
LOG_FILE_DEFAULT   = u'/tmp/sth.log'
LOG_OWNER          = u'log_owner'
LOG_GROUP          = u'log_group'
LOG_MOD            = u'log_mod'
ROOT               = u'root'
LOG_MOD_DEFAULT    = u'777'

RANDOM                     = u'random'
CHARS_ALLOWED              = string.ascii_letters + string.digits + u'_'      # [a-zA-Z0-9_]+ regular expression
RANDOM_SERVICE_LENGTH      = u'random service length ='
RANDOM_SERVICE_PATH_LENGTH = u'random service path length ='

STH_DATABASE_PREFIX   = u'sth'
STH_COLLECTION_PREFIX = u'sth'
AGGR                  = u'aggr'
URL_PATH              = u'STH/v1/contextEntities'

# headers constants
HEADER_ACCEPT                             = u'Accept'
HEADER_CONTENT_TYPE                       = u'Content-Type'
HEADER_APPLICATION                        = u'application/json'
HEADER_SERVICE                            = u'Fiware-Service'
HEADER_SERVICE_PATH                       = u'Fiware-ServicePath'
HEADER_USER_AGENT                         = u'User-Agent'



class STH:
    """
    manage Short Term Historic
    """

    def __init__(self, **kwargs):
        """
        constructor

        :param sth_protocol: web protocol (http | https)
        :param sth_host: sth host   
        :param sth_port: sth port 
        :param version : sth version 
        :param verify_version : determine if verify sth version or not (True | False)
        :param fabric_user: ssh user used to connect remotely by fabric 
        :param fabric_password: password used to connect remotely by fabric, if use cert file, password will be None 
        :param fabric_cert_file: cert_file used to connect remotely by fabric, if use password, cert_file will be None 
        :param fabric_error_retry: Number of times that fabric will attempt connecting to a new server 
        :param fabric_source_path: source path where are config templates files
        :param fabric_target_path: target path where are copied config files 
        :param fabric_sudo: operations in sth with superuser privileges (True | False)
        """
        self.protocol=kwargs.get(PROTOCOL, PROTOCOL_DEFAULT)
        self.sth_host = kwargs.get(HOST, EMPTY)
        self.sth_port = kwargs.get(PORT, EMPTY)
        self.sth_url = "%s://%s:%s/" % (self.protocol, self.sth_host, self.sth_port)
        self.sth_version = kwargs.get(VERSION, EMPTY)
        self.sth_verify_version = kwargs.get(VERIFY_VERSION, EMPTY)
        self.sth_version = kwargs.get(VERSION, EMPTY)
        self.fabric_user=kwargs.get(FABRIC_USER, EMPTY)
        self.fabric_password=kwargs.get(FABRIC_PASSWORD, EMPTY)
        self.fabric_cert_file=kwargs.get(FABRIC_CERT_FILE, EMPTY)
        self.fabric_error_retry=kwargs.get(FABRIC_ERROR_RETRY, 1)
        self.fabric_source_path=kwargs.get(FABRIC_SOURCE_PATH, EMPTY)
        self.fabric_target_path=kwargs.get(FABRIC_TARGET_PATH, EMPTY)
        self.fabric_sudo=kwargs.get(FABRIC_SUDO, False)
        self.log_file=kwargs.get(LOG_FILE, LOG_FILE_DEFAULT)
        self.log_owner=kwargs.get(LOG_OWNER, ROOT)
        self.log_group=kwargs.get(LOG_GROUP, ROOT)
        self.log_mod=kwargs.get(LOG_MOD, LOG_MOD_DEFAULT)


    def verify_mongo_version(self):
        """
        verify mongo version
        if the version is incorrect show an error with both versions, the used and the expected
        """
        world.mongo.connect()
        resp = world.mongo.eval_version()
        world.mongo.disconnect()
        assert resp == u'OK', resp

    def drop_all_test_databases(self):
        """
        drop all te
        sts databases with prefix
        """
        myfab = FabricSupport(host=self.sth_host, user=self.fabric_user, password=self.fabric_password, cert_file=self.fabric_cert_file, retry=self.fabric_error_retry, hide=True, sudo=self.fabric_sudo)
        myfab.run("sh drop_database_mongo.sh sth_test", path="%s/%s" % (self.fabric_target_path, u'resources'), sudo=False)

    def verify_sth_version(self):
        """
        verify sth version
        """
        if self.sth_verify_version.lower().find("true") >= 0:
            resp=http_utils.request(http_utils.GET, url=self.sth_url+VERSION)
            assert resp.status_code == 200, " ERROR - verifying sth version, error in status code. \n code: %s\n body: %s " % (str(resp.status_code), str(resp.text))
            dict_json = general_utils.convert_str_to_dict(resp.text, general_utils.JSON)
            assert dict_json[VERSION] == self.sth_version, " ERROR -- the sth version mismatch...\n received: %s \n expected: %s" % (dict_json[VERSION], self.sth_version)

    def init_log_file(self):
        """
        reinitialize log file
        delete and create a new log file (empty)
        """
        myfab = FabricSupport(host=self.sth_host, user=self.fabric_user, password=self.fabric_password, cert_file=self.fabric_cert_file, retry=self.fabric_error_retry, hide=False, sudo=self.fabric_sudo)
        log = Remote_Log (file=self.log_file, fabric=myfab)
        log.delete_log_file()
        log.create_log_file(owner=self.log_owner, group=self.log_group, mod=self.log_mod)

    def sth_service(self, operation):
        """
        cygnus service (status | stop | start | restart)
        :param operation:
        """
        myfab = FabricSupport(host=self.sth_host, user=self.fabric_user, password=self.fabric_password, cert_file=self.fabric_cert_file, retry=self.fabric_error_retry, hide=True, sudo=self.fabric_sudo)
        if self.sth_host != "localhost" and self.sth_host != "127.0.0.1":
            myfab.run("sudo service sth %s" % operation, path=self.fabric_target_path, sudo=False)

    def configuration(self, service, service_path, entity_type, entity_id, attributes_number, attributes_name, attribute_type):
        """
        configuration values
        """
        db_test_prefix = u'test_'
        # service
        if service.find(RANDOM_SERVICE_LENGTH) >= 0:
            characters = int(service.split(" = ")[1])
            self.service = db_test_prefix+general_utils.string_generator(characters-len(db_test_prefix), CHARS_ALLOWED)
        else:
            self.service = service

        # service_path
        if service_path.find(RANDOM_SERVICE_PATH_LENGTH) >= 0:
            characters = int(service_path.split(" = ")[1])
            self.service_path = "/"+general_utils.string_generator(characters, CHARS_ALLOWED).lower()
        else:
            self.service_path = service_path.lower()

        # entity_type and entity id
        self.entity_type = entity_type.lower()
        self.entity_id   = entity_id.lower()

        #attributes
        self.attributes_number    = int(attributes_number)
        self.attributes_name      = attributes_name
        self.attribute_type       = attribute_type
        self.notifications_number = 0

    def get_timestamp_remote(self):
        """
        return date-time in timestamp from sth server
        :return float
        """
        myfab = FabricSupport(host=self.sth_host, user=self.fabric_user, password=self.fabric_password, cert_file=self.fabric_cert_file, retry=self.fabric_error_retry, hide=True, sudo=self.fabric_sudo)
        return float(myfab.run("date +%s"))  # get timestamp

    def received_notification(self, attribute_value, metadata_value, content):
        """
        notifications
        :param attribute_value: attribute value
        :param metadata_value: metadata value (true or false)
        :param content: xml or json
        """
        self.notifications_number = self.notifications_number + 1
        self.resp = None
        self.date_time = None
        self.content = content
        self.metadata_value = metadata_value
        metadata_attribute_number = 1
        notification = Notifications (self.sth_url+STH_NOTIFICATION, tenant=self.service, service_path=self.service_path, content=self.content)
        if self.metadata_value.lower() == "true":
            notification.create_metadatas_attribute(metadata_attribute_number, RANDOM, RANDOM, RANDOM)
        notification.create_attributes (self.attributes_number, self.attributes_name, self.attribute_type, attribute_value)
        self.resp = notification.send_notification(self.entity_id, self.entity_type)

        self.date_time         = self.get_timestamp_remote()
        self.attributes        = notification.get_attributes()
        self.attributes_name   = notification.get_attributes_name()
        self.attributes_value  = notification.get_attributes_value()
        return self.resp

    def receives_n_notifications(self, notif_number, attribute_value_init):
        """
        receives N notifications with consecutive values, without metadatas and json content
        :param attribute_value_init: attribute value for all attributes in each notification increment in one
        :param notif_number: number of notification
        """
        for i in range(int(notif_number)):
            temp_value = Decimal(attribute_value_init) + i
            world.sth.received_notification(str(temp_value), "False", "json")
        self.attributes_value = attribute_value_init

    def drop_database_in_mongo(self, driver):
         """
         delete database and collections in mongo
         :param driver: mongo instance
         """
         driver.connect("%s_%s" % (STH_DATABASE_PREFIX, self.service))
         driver.drop_database()
         driver.disconnect()

    def __create_headers(self):
        """
        create the header for different requests
        :return: headers dictionary
        """
        return {HEADER_ACCEPT: HEADER_APPLICATION, HEADER_CONTENT_TYPE: HEADER_APPLICATION, HEADER_SERVICE: self.service, HEADER_SERVICE_PATH: self.service_path}

    def ask_for_raw_or_aggregated(self, step):
        """
        ask for raw or aggregated with queries parameters
        :param step: paginated parameters: [OPTIONAL]
                      the format of the table is:
                          | parameter | value               |
                          | hLimit    | 10                  |
                          | hOffset   | 3                   |
                          | dateFrom  | 2015-02-14T00:00:00 |
                          | dateTo    | 2015-12-31T00:00:00 |
        """
        self.resolution = EMPTY
        self.method = EMPTY
        self.last_n  = EMPTY
        self.h_limit  = EMPTY
        self.h_offset = EMPTY
        self.resp = None
        initial = True
        params = EMPTY
        for line in step.hashes:  # get step parameters. they are optional
            if initial:
                initial = False
            else:
                params = params + "&"
            if line["parameter"] == u'aggrMethod': self.method     = line["value"]
            if line["parameter"] == u'aggrPeriod': self.resolution = line["value"]
            if line["parameter"] == u'lastN':      self.last_n     = line["value"]
            if line["parameter"] == u'hLimit':     self.h_limit    = line["value"]
            if line["parameter"] == u'hOffset':    self.h_offset   = line["value"]

            params = params + "%s=%s" % (line["parameter"], line["value"]) # ex: ?hLimit=30&hOffset=0&dateFrom=2015-02-14T00:00:00&dateTo=2015-12-31T00:00:00

        url = "%s://%s:%s/%s/type/%s/id/%s/attributes/%s_%s?%s" % (self.protocol, self.sth_host, self.sth_port, URL_PATH, self.entity_type, self.entity_id, self.attributes_name, "0", params)
        self.resp = http_utils.request(http_utils.GET, url=url, headers=self.__create_headers())

    # --------------------------- verifications -------------------------------------------

    def verify_values_in_mongo(self):
        """
        verify attribute value and type from mongo
        :return document dict (cursor)
        """
        find_dict = { "attrName": {'$regex':'%s.*' % (self.attributes_name)}, #the regular expression is because in  multi attribute the name is with postfix <_value>. ex: temperature_0
                      "attrType" : self.attribute_type,
                      "attrValue" : str(self.attributes_value)
        }
        world.mongo.connect("%s_%s" % (STH_DATABASE_PREFIX, self.service))
        world.mongo.choice_collection("%s_%s_%s_%s" % (STH_COLLECTION_PREFIX, self.service_path, self.entity_id, self.entity_type))
        cursor = world.mongo.find_with_retry(find_dict)
        assert cursor.count() != 0, " ERROR - the attributes with prefix %s has not been stored in mongo successfully" % (self.attributes_name)
        world.mongo.disconnect()

    def verify_aggregates_in_mongo(self, resolution):
        """
        verify aggregates from mongo:
            - origin, max, min, sum sum2
        :param resolution: resolutions type (  month | day | hour | minute | second )
        """
        time_zone = 2
        find_dict = {"_id.attrName" :  {'$regex':'%s.*' % (self.attributes_name)}, #the regular expression is because in  multi attribute the name is with postfix + <_value>. ex: temperature_0
                     "_id.resolution" : resolution}

        origin_year   = general_utils.get_date_only_one_value(self.date_time, "year")
        origin_month  = general_utils.get_date_only_one_value(self.date_time, "month")
        origin_day    = general_utils.get_date_only_one_value(self.date_time, "day")
        origin_hour   = int(general_utils.get_date_only_one_value(self.date_time, "hour"))-time_zone
        if origin_hour < 10: origin_hour = u'0' + str(origin_hour)
        origin_minute = general_utils.get_date_only_one_value(self.date_time, "minute")
        origin_second = general_utils.get_date_only_one_value(self.date_time, "second")

        world.mongo.connect("%s_%s" % (STH_DATABASE_PREFIX, self.service))
        world.mongo.choice_collection("%s_%s_%s_%s.%s" % (STH_COLLECTION_PREFIX, self.service_path, self.entity_id, self.entity_type, AGGR))
        cursor = world.mongo.find_with_retry(find_dict)
        assert cursor.count() != 0, " ERROR - the aggregated has not been stored in mongo successfully "
        doc_list = world.mongo.get_cursor_value(cursor)   # get all dictionaries into a cursor, return a list

        for doc in doc_list:

            offset = int(general_utils.get_date_only_one_value(self.date_time, resolution))
            if resolution == "month":
                offset=offset-1
                origin_by_resolution = "%s-01-01 00:00:00" % (origin_year)
            elif resolution == "day":
                offset=offset-1
                origin_by_resolution = "%s-%s-01 00:00:00" % (origin_year, origin_month)
            elif resolution == "hour":
                offset=offset-time_zone
                origin_by_resolution = "%s-%s-%s 00:00:00" % (origin_year, origin_month, origin_day)
            elif resolution == "minute":
                origin_by_resolution = "%s-%s-%s %s:00:00" % (origin_year, origin_month, origin_day, origin_hour)
            elif resolution == "second":
                c = 0
                MAX_SECS = 20
                while (c < MAX_SECS):
                    if float(doc["points"][offset]["min"]) == float(self.attributes_value):
                        break
                    offset = offset - 1
                    if offset < 0: offset = 59
                    c = c + 1
                if (origin_second < c): origin_minute = origin_minute - 1
                origin_by_resolution = "%s-%s-%s %s:%s:00" % (origin_year, origin_month, origin_day, origin_hour, origin_minute)
            else:
                assert False, " ERROR - resolution type \"%s\" is not allowed, review your tests in features..." % (resolution)

            assert str(doc["_id"]["origin"]) == origin_by_resolution, " ERROR -- in origin field by the %s resolution in %s attribute" % (resolution, str(doc["_id"]["attrName"]))
            assert float(doc["points"][offset]["min"]) == float(self.attributes_value), " ERROR -- in minimun value into offset %s in %s attribute" % (str(offset), str(doc["_id"]["attrName"]))
            assert float(doc["points"][offset]["max"]) == float(self.attributes_value), " ERROR -- in maximun value into offset %s in %s attribute" % (str(offset), str(doc["_id"]["attrName"]))
            assert float(doc["points"][offset]["sum"]) == float(self.attributes_value), " ERROR -- in sum value into offset %s in %s attribute" % (str(offset), str(doc["_id"]["attrName"]))
            assert float(doc["points"][offset]["sum2"]) == (float(self.attributes_value)*float(self.attributes_value)), " ERROR -- in sum2 value into offset %s in %s attribute" % (str(offset), str(doc["_id"]["attrName"]))
        world.mongo.disconnect()

    def verify_aggregates_is_not_in_mongo(self, resolution):
        """
        verify that aggregates is not stored in mongo:
        :param resolution: resolutions type (  month | day | hour | minute | second )
        """
        find_dict = {"_id.attrName" :  {'$regex':'%s.*' % (self.attributes_name)}, #the regular expression is because in  multi attribute the name is with postfix + <_value>. ex: temperature_0
                     "_id.resolution" : resolution }
        world.mongo.connect("%s_%s" % (STH_DATABASE_PREFIX, self.service))
        world.mongo.choice_collection("%s_%s_%s_%s.%s" % (STH_COLLECTION_PREFIX, self.service_path, self.entity_id, self.entity_type, AGGR))
        cursor = world.mongo.find_data(find_dict)
        assert cursor.count() == 0, " ERROR - the aggregated has been stored in mongo."
        world.mongo.disconnect()

    def verify_log(self, label, text):
        """
        Verify in log file if a label with a text exists
        :param label: label to find
        :param text: text to find (begin since the end)
        """
        myfab = FabricSupport(host=self.sth_host, user=self.fabric_user, password=self.fabric_password, cert_file=self.fabric_cert_file, retry=self.fabric_error_retry, hide=True, sudo=self.fabric_sudo)
        log = Remote_Log (fabric=myfab, file=self.log_file)
        line = log.find_line(label, text)

        #verify if a line with a level and a text exists in the log
        assert line != None, "ERROR  - label: \"%s\" and text: \"%s\" is not found.    \n       - %s" % (label, text, line)
        # verify if the new line in log has been wrote after the notification was sent
        assert self.date_time < log.get_line_time_in_log(line), "ERROR - the lines has not  been logged"

    def validate_HTTP_code(self, http_code):
        """
        validate http status code
        :param resp: response from server
        :param expected_status_code: Http code expected
        """
        http_utils.assert_status_code(http_utils.status_codes[http_code], self.resp,
            "Wrong status code received: %s. Expected: %s. \n\nBody content: %s" % (str(self.resp.status_code), str(http_utils.status_codes[http_code]), str(self.resp.text)))

    def validate_that_the_aggregated_is_returned_successfully(self):
        """
        validate that the aggregated is returned successfully via REST
        """
        time_zone = 2
        dupla = {"month": "year", "day": "month", "hour": "day", "minute": "hour", "second": "minute"}
        offset = int(general_utils.get_date_only_one_value(self.date_time, self.resolution))
        origin_year   = general_utils.get_date_only_one_value(self.date_time, "year")
        origin_month  = general_utils.get_date_only_one_value(self.date_time, "month")
        origin_day    = general_utils.get_date_only_one_value(self.date_time, "day")
        origin_hour   = int(general_utils.get_date_only_one_value(self.date_time, "hour"))-time_zone
        if origin_hour < 10: origin_hour = u'0' + str(origin_hour)
        origin_minute = general_utils.get_date_only_one_value(self.date_time, "minute")
        origin_second = general_utils.get_date_only_one_value(self.date_time, "second")

        context_json = general_utils.convert_str_to_dict(self.resp.text, general_utils.JSON)
        if self.resolution == "month":
            origin_by_resolution = "%s-01-01T00:00:00.000Z" % (origin_year) # 2015-01-01T00:00:00.000Z
        elif self.resolution == "day":
            origin_by_resolution = "%s-%s-01T00:00:00.000Z" % (origin_year, origin_month)
        elif self.resolution == "hour":
            offset=offset-time_zone
            origin_by_resolution = "%s-%s-%sT00:00:00.000Z" % (origin_year, origin_month, origin_day)
        elif self.resolution == "minute":
            origin_by_resolution = "%s-%s-%sT%s:00:00.000Z" % (origin_year, origin_month, origin_day, origin_hour)
        elif self.resolution == "second":
            offset = int(context_json["contextResponses"][0]["contextElement"]["attributes"][0]["values"][0]["points"][0]["offset"])
            c = int(origin_second) - int(offset)
            if (int(origin_second)-c) < 0: origin_minute = str(int(origin_minute) - 1)
            origin_by_resolution = "%s-%s-%sT%s:%s:00.000Z" % (origin_year, origin_month, origin_day, origin_hour, origin_minute)
        else:
            assert False, " ERROR - resolution type \"%s\" is not allowed, review your tests in features..." % (self.resolution)

        # attributes
        assert str(context_json["contextResponses"][0]["contextElement"]["attributes"][0]["name"]) == "%s_%s" % (self.attributes_name, u'0'), \
            "  ERROR - in aggregated with name %s_%s" % (self.attributes_name, u'0')
        # values
        assert str(context_json["contextResponses"][0]["contextElement"]["attributes"][0]["values"][0]["_id"]["attrName"]) == "%s_%s" % (self.attributes_name, u'0'), \
             "  ERROR - in aggregated with name %s_%s" % (self.attributes_name, u'0')
        assert str(context_json["contextResponses"][0]["contextElement"]["attributes"][0]["values"][0]["_id"]["origin"]) == origin_by_resolution, \
             "  ERROR - in aggregated with origin %s" % (origin_by_resolution)
        assert str(context_json["contextResponses"][0]["contextElement"]["attributes"][0]["values"][0]["_id"]["resolution"]) == self.resolution, \
             "  ERROR - in aggregated with resolution %s" % (self.resolution)
        assert str(context_json["contextResponses"][0]["contextElement"]["attributes"][0]["values"][0]["_id"]["range"]) == dupla[self.resolution], \
             "  ERROR - in aggregated with range %s" % (dupla[self.resolution])
        # points
        assert str(context_json["contextResponses"][0]["contextElement"]["attributes"][0]["values"][0]["points"][0]["offset"]) == str(offset), \
             "  ERROR - in aggregated with offset %s" % (offset)
        if self.method == "sum":
            assert float(context_json["contextResponses"][0]["contextElement"]["attributes"][0]["values"][0]["points"][0]["sum"]) == float(self.attributes_value), \
             "  ERROR - in aggregated with sum %s" % (str(self.attributes_value))
        elif self.method == "sum2":
            assert float(context_json["contextResponses"][0]["contextElement"]["attributes"][0]["values"][0]["points"][0]["sum2"]) == (float(self.attributes_value)*float(self.attributes_value)), \
             "  ERROR - in aggregated with sum2 %s" % (str((float(self.attributes_value)*float(self.attributes_value))))
        elif self.method == "min":
            assert float(context_json["contextResponses"][0]["contextElement"]["attributes"][0]["values"][0]["points"][0]["min"]) == float(self.attributes_value), \
             "  ERROR - in aggregated with min %s" % (str(self.attributes_value))
        elif self.method == "max":
            assert float(context_json["contextResponses"][0]["contextElement"]["attributes"][0]["values"][0]["points"][0]["max"]) == float(self.attributes_value), \
             "  ERROR - in aggregated with max %s" % (str(self.attributes_value))

        # contextElement
        assert str(context_json["contextResponses"][0]["contextElement"]["id"]) == self.entity_id, \
             "  ERROR - in aggregated with entity id %s" % (self.entity_id)
        assert str(context_json["contextResponses"][0]["contextElement"]["type"]) == self.entity_type, \
             "  ERROR - in aggregated with entity type %s" % (self.entity_type)
        assert str(context_json["contextResponses"][0]["contextElement"]["isPattern"]) == "False", \
             "  ERROR - in aggregated with isPattern equal to false"

        # context Responses
        assert str(context_json["contextResponses"][0]["statusCode"]["code"]) == "200", \
             "  ERROR - in aggregated with status Code equal to 200"
        assert str(context_json["contextResponses"][0]["statusCode"]["reasonPhrase"]) == "OK", \
             "  ERROR - in aggregated with reason Phrase equal to OK"

    def validate_that_the_aggregated_is_calculated_successfully(self):
        """
        validate that the aggregated is calculated successfully
        """
        sum  = 0
        sum2 = 0
        context_json = general_utils.convert_str_to_dict(self.resp.text, general_utils.JSON)
        if self.method == "min":
            assert float(context_json["contextResponses"][0]["contextElement"]["attributes"][0]["values"][0]["points"][0]["min"]) == float(self.attributes_value), \
             "  ERROR - in aggregated with min %s" % (str(context_json["contextResponses"][0]["contextElement"]["attributes"][0]["values"][0]["points"][0]["min"]))
        elif self.method == "max":
            assert float(context_json["contextResponses"][0]["contextElement"]["attributes"][0]["values"][0]["points"][0]["max"]) == float(Decimal(self.attributes_value) + self.notifications_number - 1), \
             "  ERROR - in aggregated with max %s" % (str(context_json["contextResponses"][0]["contextElement"]["attributes"][0]["values"][0]["points"][0]["max"]))
        elif self.method == "sum":
            for i in range(int(self.notifications_number)):
                v = int(self.attributes_value) + i
                sum = sum + v
            assert float(context_json["contextResponses"][0]["contextElement"]["attributes"][0]["values"][0]["points"][0]["sum"]) == float(sum), \
             "  ERROR - in aggregated with sum %s" % (str(context_json["contextResponses"][0]["contextElement"]["attributes"][0]["values"][0]["points"][0]["sum"]))
        elif self.method == "sum2":
            for i in range(int(self.notifications_number)):
                v = int(self.attributes_value) + i
                sum2 = sum2 + (v*v)
            assert float(context_json["contextResponses"][0]["contextElement"]["attributes"][0]["values"][0]["points"][0]["sum2"]) == float(sum2), \
             "  ERROR - in aggregated with sum2 %s" % (str(context_json["contextResponses"][0]["contextElement"]["attributes"][0]["values"][0]["points"][0]["sum2"]))

    def verify_that_not_return_aggregated_values(self):
        """
        verify that not return aggregated values
        """
        for i in range (self.attributes_number):
            context_json = general_utils.convert_str_to_dict(self.resp.text, general_utils.JSON)
            assert len(context_json["contextResponses"][0]["contextElement"]["attributes"][0]["values"]) == 0, \
                "  ERROR - aggregated values are returned:\n %s" % str(context_json["contextResponses"][0]["contextElement"]["attributes"][0]["values"])

    def validate_that_the_raw_is_returned_successfully(self):
        """
        validate that the raw is returned successfully
        """
        context_json = general_utils.convert_str_to_dict(self.resp.text, general_utils.JSON)
        # attributes
        assert str(context_json["contextResponses"][0]["contextElement"]["attributes"][0]["name"]) == "%s_%s" % (self.attributes_name, u'0'), \
            "  ERROR - in raw with name %s_%s" % (self.attributes_name, u'0')

        assert str(context_json["contextResponses"][0]["contextElement"]["id"]) == self.entity_id, \
            "  ERROR - in raw with entity id %s" % (self.entity_id)
        assert str(context_json["contextResponses"][0]["contextElement"]["type"]) == self.entity_type, \
            "  ERROR - in raw with entity type %s" % (self.entity_type)

        assert str(context_json["contextResponses"][0]["statusCode"]["code"]) == "200", \
            "  ERROR - in raw with status code - code  %s" % (str(context_json["contextResponses"][0]["statusCode"]["code"]))
        assert str(context_json["contextResponses"][0]["statusCode"]["reasonPhrase"]) == "OK", \
            "  ERROR - in raw with status code - code  %s" % (str(context_json["contextResponses"][0]["statusCode"]["reasonPhrase"]))
        # values
        values_number = len(context_json["contextResponses"][0]["contextElement"]["attributes"][0]["values"])
        if self.last_n != EMPTY:
            quantity = self.last_n
        else:
            quantity = self.h_limit
        if values_number < quantity:
            quantity = values_number

        for i in range(quantity):
            if self.last_n == EMPTY:
                temp_value = Decimal(self.attributes_value) + i + int(self.h_offset)
            else:
                if int(self.notifications_number) < int(self.last_n): self.last_n = int(self.notifications_number)
                temp_value = Decimal(self.attributes_value) + int(self.notifications_number) - int(self.last_n) + i

            assert str(context_json["contextResponses"][0]["contextElement"]["attributes"][0]["values"][i]["attrValue"]) == str (temp_value), \
                "  ERROR - in raw with attribute value in position: %s" % (str(i))
            assert str(context_json["contextResponses"][0]["contextElement"]["attributes"][0]["values"][i]["recvTime"]) != EMPTY, \
                "  ERROR - in raw with recvTime in position: %s" % (str(i))



