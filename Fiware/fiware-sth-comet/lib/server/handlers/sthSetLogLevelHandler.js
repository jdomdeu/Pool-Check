/*
 * Copyright 2016 Telefónica Investigación y Desarrollo, S.A.U
 *
 * This file is part of the Short Time Historic (STH) component
 *
 * STH is free software: you can redistribute it and/or
 * modify it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the License,
 * or (at your option) any later version.
 *
 * STH is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public
 * License along with STH.
 * If not, see http://www.gnu.org/licenses/.
 *
 * For those usages not covered by the GNU Affero General Public License
 * please contact with: [german.torodelvalle@telefonica.com]
 */

const ROOT_PATH = require('app-root-path');
const sthLogger = require('logops');
const sthServerUtils = require(ROOT_PATH + '/lib/server/utils/sthServerUtils');

/**
 * Sets the log level to the value passed in the request
 * @param request The received request
 * @param reply hapi's server reply() function
 */
function setLogLevelHandler(request, reply) {
    request.sth = request.sth || {};
    request.sth.context = sthServerUtils.getContext(request);

    sthLogger.debug(request.sth.context, request.method.toUpperCase() + ' ' + request.url.path);

    const level = request.query.level.toUpperCase() === 'WARNING' ? 'WARN' : request.query.level.toUpperCase();
    sthLogger.setLevel(level);

    sthLogger.info(request.sth.context, 'Log level set to: ' + level);

    const response = reply();
    sthServerUtils.addFiwareCorrelator(request, response);
}

module.exports = setLogLevelHandler;
