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
#  iot_support at tid.es
#
__author__ = 'Iván Arias León (ivan.ariasleon at telefonica dot com)'

from lettuce import step, world

from tools.properties_config import Properties

@step (u'update properties.json file from "([^"]*)" and sudo local "([^"]*)"')
def copy_properties_file_from_and_sudo(step, file_name, sudo_run):
    """
    copy properties.json specific to feature from setting folder, read properties and create necessaries class
    :param step:
    :param file_name: file name of configuration associated at features, stored in settings folder
    :param sudo_run:  with superuser privileges (True | False)
    """
    if not world.background_executed:
        properties = Properties (file=file_name, sudo=sudo_run)
        properties.read_properties()
        properties.storing_dictionaries()

@step (u'restart sth service. This execution is only once "([^"]*)"')
def restart_sth_service_this_execution_is_only_once(step, only_once):
    """
    restart sth service
    :param only_once: determine if the configuration is execute only once or no (True | False)
    :param step:
    """
    if not world.background_executed:
        world.sth.sth_service("restart")
    if only_once.lower() == "true":
        world.background_executed = True
    else:
         world.background_executed = False

@step (u'verify if sth is installed correctly')
def verify_if_sth_is_installed_correctly(step):
    """
    verify if sth is installed correctly
    :param step:
    """
    world.sth.verify_sth_version()

@step (u'mongo is installed correctly')
def mongo_is_installed_correctly(step):
    """
    mongo is installed correctly, main verify mongo version (see properties.json)
    if the version is incorrect show an error with both versions, the used and the expected
    :param step:
    """
    world.sth.verify_sth_version()

@step(u'delete database in mongo')
def delete_database_in_mongo(step):
    """
    delete database and collections in mongo
    :param step:
    """
    world.sth.drop_database_in_mongo(world.mongo)

@step (u'reinitialize log file')
def reinitialize_log_file(step):
     """
     reinitialize log file
     :param step:
     """
     world.sth.init_log_file()

#  -------------------------------  notifications ----------------------------------------------------------------------

@step (u'service "([^"]*)", service path "([^"]*)", entity type "([^"]*)", entity_id "([^"]*)", with attribute number "([^"]*)", attribute name "([^"]*)" and attribute type "([^"]*)"')
def a_service_service_path_resource_with_attribute_number_attribute_name_and_attribute_type (step, service, service_path, entity_type, entity_id, attributes_number, attribute_name, attribute_type):
    """
    define configuration in notification
    :param entity_type:
    :param entity_id:
    :param step:
    :param service:
    :param service_path:
    :param attributes_number:
    :param attribute_name:
    :param attribute_type:
    """
    world.sth.configuration(service, service_path, entity_type, entity_id, attributes_number, attribute_name, attribute_type)

@step (u'receives a notification with attributes value "([^"]*)", metadata value "([^"]*)" and content "([^"]*)"')
def receives_a_notification_with_attributes_value_metadata_value_and_content (step, attributes_value, metadata_value, content):
    """
    store notification in mongo
    :param step:
    :param attribute_value:
    :param metadata_value:
    :param content:
    """
    world.sth.received_notification(attributes_value, metadata_value, content)

@step (u'receives "([^"]*)" notifications with consecutive values beginning with "([^"]*)" and with step one')
def receives_notifications_with_consecutive_values(step, notif_number, attribute_value_init):
    """
    receives N notifications with consecutive values, without metadatas and json content
    :param step:
    :param notif_number:
    """
    world.sth.receives_n_notifications(notif_number, attribute_value_init)

# ------------------------------------------- aggregated and raw -------------------------------------------------------
@step (u'ask for aggregates with queries parameters')
@step (u'ask for raw with queries parameters')
def ask_for_raw_with_queries_parameters(step):
    """
    ask for raw with queries parameters
    :param step: paginated parameters: [OPTIONAL]
                      the format of the table is:
                          | parameter | value               |
                          | hLimit    | 10                  |
                          | hOffset   | 3                   |
                          | dateFrom  | 2015-02-14T00:00:00 |
                          | dateTo    | 2015-12-31T00:00:00 |
    """
    world.sth.ask_for_raw_or_aggregated(step)

 # ------------------------------------------------ validations --------------------------------------------------------

@step (u'validate that the attribute value and type are stored in mongo')
def validate_that_the_attribute_value_metadata_and_type_are_stored_in_mongo(step):
    """
    Validate that the attributes values type are stored in mongo
    :param step:
    """
    world.sth.verify_values_in_mongo()

@step(u'validate that the aggregated value is generate by resolution "([^"]*)" in mongo')
def validate_that_the_aggregated_values_are_generate_in_mongo(step, resolution):
    """
    Validate that the aggregated value is generate in mongo by several resolutions
          - origin, max, min, sum sum2
    :param step:
    :param resolution: resolutions type (  month | day | hour | minute | second )
    """
    world.sth.verify_aggregates_in_mongo(resolution)

@step(u'validate that the aggregated value is not generate by resolution "([^"]*)" in mongo')
def validate_that_the_aggregated_values_are_generate_in_mongo(step, resolution):
    """
    Validate that the aggregated value is not generate in mongo by several resolutions
          - origin, max, min, sum sum2
    :param step:
    :param resolution: resolutions type (  month | day | hour | minute | second )
    """
    world.sth.verify_aggregates_is_not_in_mongo(resolution)

@step(u'I receive an "([^"]*)" http code')
def i_receive_an_http_code (step, http_code):
    """
    validate http code in response
    :param httpCode:  http code for validate
    """
    world.sth.validate_HTTP_code(http_code)

@step(u'validate that the aggregated is returned successfully')
def validate_that_the_aggregated_is_returned_successfully(step):
    """
    validate that the aggregated is returned successfully via REST
    :param step:
    """
    world.sth.validate_that_the_aggregated_is_returned_successfully()

@step(u'verify that not return aggregated values')
def verify_that_not_return_aggregated_values(step):
    """
    verify that not return aggregated values
    :param step:
    """
    world.sth.verify_that_not_return_aggregated_values()

@step(u'validate that the aggregated is calculated successfully')
def validate_that_the_aggregated_is_calculated_successfully(step):
    """
    validate that the aggregated is calculated successfully
    :param step:
    """
    world.sth.validate_that_the_aggregated_is_calculated_successfully()

@step (u'check in log, label "([^"]*)" and text "([^"]*)"')
def check_in_log_label_and_text(step, label, text):
    """
    Verify in log file if a label with a text exists
    :param step:
    :param label: label to find
    :param text: text to find (begin since the end)
    """
    world.sth.verify_log(label, text)

@step(u'validate that the raw is returned successfully')
def validate_that_the_raw_is_returned_successfully(step):
    """
    validate that the raw is returned successfully
    :param step:
    """
    world.sth.validate_that_the_raw_is_returned_successfully()