/*
 * Copyright 2015 Telefónica Investigación y Desarrollo, S.A.U
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
const STH_CONFIGURATION_PATH = ROOT_PATH + '/lib/configuration/sthConfiguration';
let sthConfig = require(STH_CONFIGURATION_PATH);
const expect = require('expect.js');
const clearRequire = require('clear-require');

const DEFAULT_VALUES = {
    LOGOPS_LEVEL: 'INFO',
    LOGOPS_FORMAT: 'pipe',
    STH_HOST: 'localhost',
    STH_PORT: 8666,
    FILTER_OUT_EMPTY: true,
    DEFAULT_SERVICE: 'testservice',
    DEFAULT_SERVICE_PATH: '/testservicepath',
    AGGREGATION_BY: ['day', 'hour', 'minute'],
    TEMPORAL_DIR: 'temp',
    DATA_MODEL: 'collection-per-entity',
    DB_USERNAME: '',
    DB_PASSWORD: '',
    DB_URI: 'localhost:27017',
    REPLICA_SET: '',
    DB_PREFIX: 'sth_',
    COLLECTION_PREFIX: 'sth_',
    POOL_SIZE: 5,
    WRITE_CONCERN: '1',
    SHOULD_STORE: 'both',
    TRUNCATION_EXPIRE_AFTER_SECONDS: 0,
    TRUNCATION_SIZE: 0,
    TRUNCATION_MAX: 0,
    IGNORE_BLANK_SPACES: true,
    NAME_ENCODING: false,
    PROOF_OF_LIFE_INTERVAL: 60,
    PROCESSED_REQUEST_LOG_STATISTICS_INTERVAL: 60
};

describe('sthConfiguration tests', function() {
    describe('default values', function() {
        if (Object.keys(process.env).indexOf('LOGOPS_LEVEL') === -1) {
            it('should set the logging level configuration parameter to its default value', function() {
                expect(sthConfig.LOGOPS_LEVEL).to.equal(DEFAULT_VALUES.LOGOPS_LEVEL);
            });
        }

        if (Object.keys(process.env).indexOf('LOGOPS_FORMAT') === -1) {
            it('should set the logging format configuration parameter to its default value', function() {
                expect(sthConfig.LOGOPS_FORMAT).to.equal(DEFAULT_VALUES.LOGOPS_FORMAT);
            });
        }

        if (Object.keys(process.env).indexOf('STH_HOST') === -1) {
            it('should set the STH server host configuration parameter to its default value', function() {
                expect(sthConfig.STH_HOST).to.equal(DEFAULT_VALUES.STH_HOST);
            });
        }

        if (Object.keys(process.env).indexOf('STH_PORT') === -1) {
            it('should set the STH server port configuration parameter to its default value', function() {
                expect(sthConfig.STH_PORT).to.equal(DEFAULT_VALUES.STH_PORT);
            });
        }

        if (Object.keys(process.env).indexOf('DEFAULT_SERVICE') === -1) {
            it('should set the default service configuration parameter to its default value', function() {
                expect(sthConfig.DEFAULT_SERVICE).to.equal(DEFAULT_VALUES.DEFAULT_SERVICE);
            });
        }

        if (Object.keys(process.env).indexOf('DEFAULT_SERVICE_PATH') === -1) {
            it('should set the default service path configuration parameter to its default value', function() {
                expect(sthConfig.DEFAULT_SERVICE_PATH).to.equal(DEFAULT_VALUES.DEFAULT_SERVICE_PATH);
            });
        }

        if (Object.keys(process.env).indexOf('FILTER_OUT_EMPTY') === -1) {
            it('should set the filter out empty configuration parameter to its default value', function() {
                expect(sthConfig.FILTER_OUT_EMPTY).to.equal(DEFAULT_VALUES.FILTER_OUT_EMPTY);
            });
        }

        if (Object.keys(process.env).indexOf('AGGREGATION_BY') === -1) {
            it('should set the resolution to aggregate the data by to its default value', function() {
                DEFAULT_VALUES.AGGREGATION_BY.forEach(function(aggregationBy) {
                    expect(sthConfig.AGGREGATION_BY).to.contain(aggregationBy);
                });
            });
        }

        if (Object.keys(process.env).indexOf('TEMPORAL_DIR') === -1) {
            it('should set the temporal directory configuration parameter to its default value', function() {
                expect(sthConfig.TEMPORAL_DIR).to.equal(DEFAULT_VALUES.TEMPORAL_DIR);
            });
        }

        if (Object.keys(process.env).indexOf('DATA_MODEL') === -1) {
            it('should set the data model configuration parameter to its default value', function() {
                expect(sthConfig.DATA_MODEL).to.equal(DEFAULT_VALUES.DATA_MODEL);
            });
        }

        if (Object.keys(process.env).indexOf('DB_USERNAME') === -1) {
            it('should set the database user configuration parameter to its default value', function() {
                expect(sthConfig.DB_USERNAME).to.equal(DEFAULT_VALUES.DB_USERNAME);
            });
        }

        if (Object.keys(process.env).indexOf('DB_PASSWORD') === -1) {
            it('should set the database password configuration parameter to its default value', function() {
                expect(sthConfig.DB_PASSWORD).to.equal(DEFAULT_VALUES.DB_PASSWORD);
            });
        }

        if (Object.keys(process.env).indexOf('DB_URI') === -1) {
            it('should set the database URI configuration parameter to its default value', function() {
                expect(sthConfig.DB_URI).to.equal(DEFAULT_VALUES.DB_URI);
            });
        }

        if (Object.keys(process.env).indexOf('REPLICA_SET') === -1) {
            it('should set the database replica set configuration parameter to its default value', function() {
                expect(sthConfig.REPLICA_SET).to.equal(DEFAULT_VALUES.REPLICA_SET);
            });
        }

        if (Object.keys(process.env).indexOf('DB_PREFIX') === -1) {
            it('should set the database prefix configuration parameter to its default value', function() {
                expect(sthConfig.DB_PREFIX).to.equal(DEFAULT_VALUES.DB_PREFIX);
            });
        }

        if (Object.keys(process.env).indexOf('COLLECTION_PREFIX') === -1) {
            it('should set the collection prefix configuration parameter to its default value', function() {
                expect(sthConfig.COLLECTION_PREFIX).to.equal(DEFAULT_VALUES.COLLECTION_PREFIX);
            });
        }

        if (Object.keys(process.env).indexOf('POOL_SIZE') === -1) {
            it('should set the database pool size configuration parameter to its default value', function() {
                expect(sthConfig.POOL_SIZE).to.equal(DEFAULT_VALUES.POOL_SIZE);
            });
        }

        if (Object.keys(process.env).indexOf('WRITE_CONCERN') === -1) {
            it('should set the database write concern configuration parameter to its default value', function() {
                expect(sthConfig.WRITE_CONCERN).to.equal(DEFAULT_VALUES.WRITE_CONCERN);
            });
        }

        if (Object.keys(process.env).indexOf('SHOULD_STORE') === -1) {
            it('should set the database should store data configuration parameter to its default value', function() {
                expect(sthConfig.SHOULD_STORE).to.equal(DEFAULT_VALUES.SHOULD_STORE);
            });
        }

        if (Object.keys(process.env).indexOf('TRUNCATION_EXPIRE_AFTER_SECONDS') === -1) {
            it('should set the database truncation expiration after seconds configuration parameter to its default value', function() {
                expect(sthConfig.TRUNCATION_EXPIRE_AFTER_SECONDS).to.equal(
                    DEFAULT_VALUES.TRUNCATION_EXPIRE_AFTER_SECONDS
                );
            });
        }

        if (Object.keys(process.env).indexOf('TRUNCATION_SIZE') === -1) {
            it('should set the database truncation size configuration parameter to its default value', function() {
                expect(sthConfig.TRUNCATION_SIZE).to.equal(DEFAULT_VALUES.TRUNCATION_SIZE);
            });
        }

        if (Object.keys(process.env).indexOf('TRUNCATION_MAX') === -1) {
            it('should set the database truncation document number configuration parameter to its default value', function() {
                expect(sthConfig.TRUNCATION_MAX).to.equal(DEFAULT_VALUES.TRUNCATION_MAX);
            });
        }

        if (Object.keys(process.env).indexOf('IGNORE_BLANK_SPACES') === -1) {
            it('should set the database ignore blank spaces configuration parameter to its default value', function() {
                expect(sthConfig.IGNORE_BLANK_SPACES).to.equal(DEFAULT_VALUES.IGNORE_BLANK_SPACES);
            });
        }

        if (Object.keys(process.env).indexOf('NAME_ENCODING') === -1) {
            it('should set the database name encoding configuration parameter to its default value', function() {
                expect(sthConfig.NAME_ENCODING).to.equal(DEFAULT_VALUES.NAME_ENCODING);
            });
        }

        if (Object.keys(process.env).indexOf('PROOF_OF_LIFE_INTERVAL') === -1) {
            it('should set the proof of life interval configuration parameter to its default value', function() {
                expect(sthConfig.PROOF_OF_LIFE_INTERVAL).to.equal(DEFAULT_VALUES.PROOF_OF_LIFE_INTERVAL);
            });
        }

        if (Object.keys(process.env).indexOf('PROCESSED_REQUEST_LOG_STATISTICS_INTERVAL') === -1) {
            it('should set the processed request log statistics interval configuration parameter to its default value', function() {
                expect(sthConfig.PROCESSED_REQUEST_LOG_STATISTICS_INTERVAL).to.equal(
                    DEFAULT_VALUES.PROCESSED_REQUEST_LOG_STATISTICS_INTERVAL
                );
            });
        }
    });

    describe('setting values via environment variables', function() {
        beforeEach(function() {
            clearRequire(STH_CONFIGURATION_PATH);
        });

        it("should set the logging level configuration parameter to 'DEBUG'", function() {
            process.env.LOGOPS_LEVEL = 'debug';
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.LOGOPS_LEVEL).to.equal('DEBUG');
        });

        it('should set the logging level configuration parameter to the default value if set to an invalid value', function() {
            process.env.LOGOPS_LEVEL = 'DEXXXBUG';
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.LOGOPS_LEVEL).to.equal(DEFAULT_VALUES.LOGOPS_LEVEL);
        });

        it("should set the logging format configuration parameter to 'dev'", function() {
            process.env.LOGOPS_FORMAT = 'dev';
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.LOGOPS_FORMAT).to.equal('dev');
        });

        it('should set the logging format configuration parameter to the default value if set to an invalid value', function() {
            process.env.LOGOPS_FORMAT = 'devXXX';
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.LOGOPS_FORMAT).to.equal(DEFAULT_VALUES.LOGOPS_FORMAT);
        });

        it("should set the STH host configuration parameter to '127.0.0.1'", function() {
            process.env.STH_HOST = '127.0.0.1';
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.STH_HOST).to.equal('127.0.0.1');
        });

        it('should set the STH host configuration parameter to the default value if not set via STH_HOST', function() {
            delete process.env.STH_HOST;
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.STH_HOST).to.equal(DEFAULT_VALUES.STH_HOST);
        });

        it("should set the STH port configuration parameter to '6666'", function() {
            process.env.STH_PORT = '6666';
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.STH_PORT).to.equal(6666);
        });

        it('should set the STH port configuration parameter to the default value if not set via STH_PORT', function() {
            delete process.env.STH_PORT;
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.STH_PORT).to.equal(DEFAULT_VALUES.STH_PORT);
        });

        it('should set the STH port configuration parameter to the default value if not set to a valid number', function() {
            process.env.STH_PORT = 'ABC';
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.STH_PORT).to.equal(DEFAULT_VALUES.STH_PORT);
        });

        it("should set the default service configuration parameter to 'my_test_service'", function() {
            process.env.DEFAULT_SERVICE = 'my_test_service';
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.DEFAULT_SERVICE).to.equal('my_test_service');
        });

        it('should set the default service configuration parameter to the default value if not set via DEFAULT_SERVICE', function() {
            delete process.env.DEFAULT_SERVICE;
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.DEFAULT_SERVICE).to.equal(DEFAULT_VALUES.DEFAULT_SERVICE);
        });

        it("should set the default service path configuration parameter to '/my_test_service_path'", function() {
            process.env.DEFAULT_SERVICE_PATH = '/my_test_service_path';
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.DEFAULT_SERVICE_PATH).to.equal('/my_test_service_path');
        });

        it(
            'should set the default service path configuration parameter to the default value if not set via ' +
                'DEFAULT_SERVICE_PATH',
            function() {
                delete process.env.DEFAULT_SERVICE_PATH;
                sthConfig = require(STH_CONFIGURATION_PATH);
                expect(sthConfig.DEFAULT_SERVICE_PATH).to.equal(DEFAULT_VALUES.DEFAULT_SERVICE_PATH);
            }
        );

        it('should set the default service path configuration parameter to the default value if set to an invalid value', function() {
            process.env.DEFAULT_SERVICE_PATH = 'testservicepath'; // Not starting with '/'.
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.DEFAULT_SERVICE_PATH).to.equal(DEFAULT_VALUES.DEFAULT_SERVICE_PATH);
        });

        it("should set the filter out empty configuration parameter to 'false'", function() {
            process.env.FILTER_OUT_EMPTY = 'false';
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.FILTER_OUT_EMPTY).to.equal(false);
        });

        it('should set the filter out empty configuration parameter to the default value if not set via FILTER_OUT_EMPTY', function() {
            delete process.env.FILTER_OUT_EMPTY;
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.FILTER_OUT_EMPTY).to.equal(DEFAULT_VALUES.FILTER_OUT_EMPTY);
        });

        it('should set the filter out empty configuration parameter to the default value if not set to a valid value', function() {
            process.env.FILTER_OUT_EMPTY = 'not-false';
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.FILTER_OUT_EMPTY).to.equal(DEFAULT_VALUES.FILTER_OUT_EMPTY);
        });

        it("should set the resolutions to aggregate the data by configuration parameter to '[minute, second]'", function() {
            process.env.AGGREGATION_BY =
                '["' + sthConfig.RESOLUTION.MINUTE + '", "' + sthConfig.RESOLUTION.SECOND + '"]';
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.AGGREGATION_BY).to.contain(sthConfig.RESOLUTION.MINUTE);
            expect(sthConfig.AGGREGATION_BY).to.contain(sthConfig.RESOLUTION.SECOND);
        });

        it(
            'should set the resolutions to aggregate the data by configuration parameter to the default value ' +
                'if not set via AGGREGATION_BY',
            function() {
                delete process.env.AGGREGATION_BY;
                sthConfig = require(STH_CONFIGURATION_PATH);
                DEFAULT_VALUES.AGGREGATION_BY.forEach(function(aggregationBy) {
                    expect(sthConfig.AGGREGATION_BY).to.contain(aggregationBy);
                });
            }
        );

        it(
            'should set the resolutions to aggregate the data by configuration parameter to the default value ' +
                'if set to an invalid value',
            function() {
                process.env.AGGREGATION_BY = 'not-an-array';
                sthConfig = require(STH_CONFIGURATION_PATH);
                DEFAULT_VALUES.AGGREGATION_BY.forEach(function(aggregationBy) {
                    expect(sthConfig.AGGREGATION_BY).to.contain(aggregationBy);
                });
            }
        );

        it("should set the temporal directory configuration parameter to 'my_temp_dir'", function() {
            process.env.TEMPORAL_DIR = 'my_temp_dir';
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.TEMPORAL_DIR).to.equal('my_temp_dir');
        });

        it('should set the temporal directory configuration parameter to the default value if not set via TEMPORAL_DIR', function() {
            delete process.env.TEMPORAL_DIR;
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.TEMPORAL_DIR).to.equal(DEFAULT_VALUES.TEMPORAL_DIR);
        });

        it("should set the data model configuration parameter to 'collection-per-service-path'", function() {
            process.env.DATA_MODEL = 'collection-per-service-path';
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.DATA_MODEL).to.equal('collection-per-service-path');
        });

        it('should set the data model configuration parameter to the default value if not set via DATA_MODEL', function() {
            delete process.env.DATA_MODEL;
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.DATA_MODEL).to.equal(DEFAULT_VALUES.DATA_MODEL);
        });

        it('should set the data model configuration parameter to the default value if set to an invalid value', function() {
            process.env.DATA_MODEL = 'collection-per-invalid-value'; // Not starting with '/'.
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.DATA_MODEL).to.equal(DEFAULT_VALUES.DATA_MODEL);
        });

        it("should set the database user configuration parameter to 'db-user'", function() {
            process.env.DB_USERNAME = 'db-user';
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.DB_USERNAME).to.equal('db-user');
        });

        it('should set the database user configuration parameter to the default value if not set via DB_USERNAME', function() {
            delete process.env.DB_USERNAME;
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.DB_USERNAME).to.equal(DEFAULT_VALUES.DB_USERNAME);
        });

        it("should set the database password configuration parameter to 'db-password'", function() {
            process.env.DB_PASSWORD = 'db-password';
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.DB_PASSWORD).to.equal('db-password');
        });

        it(
            'should set the database password configuration parameter to the default value ' +
                'if not set via DB_PASSWORD',
            function() {
                delete process.env.DB_PASSWORD;
                sthConfig = require(STH_CONFIGURATION_PATH);
                expect(sthConfig.DB_PASSWORD).to.equal(DEFAULT_VALUES.DB_PASSWORD);
            }
        );

        it("should set the database URI configuration parameter to 'my.db.host.com:12345'", function() {
            process.env.DB_URI = 'my.db.host.com:12345';
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.DB_URI).to.equal('my.db.host.com:12345');
        });

        it("should set the database URI configuration parameter to 'mongodb1:27017,mongodb2:27017,mongodb3:27017'", function() {
            process.env.DB_URI = 'mongodb1:27017,mongodb2:27017,mongodb3:27017';
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.DB_URI).to.equal('mongodb1:27017,mongodb2:27017,mongodb3:27017');
        });

        it('should set the database URI configuration parameter to the default value if not set via DB_URI', function() {
            delete process.env.DB_URI;
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.DB_URI).to.equal(DEFAULT_VALUES.DB_URI);
        });

        it("should set the database replica set configuration parameter to 'the-replica-set'", function() {
            process.env.REPLICA_SET = 'the-replica-set';
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.REPLICA_SET).to.equal('the-replica-set');
        });

        it(
            'should set the database replica set configuration parameter to the default value ' +
                'if not set via REPLICA_SET',
            function() {
                delete process.env.REPLICA_SET;
                sthConfig = require(STH_CONFIGURATION_PATH);
                expect(sthConfig.REPLICA_SET).to.equal(DEFAULT_VALUES.REPLICA_SET);
            }
        );

        it("should set the database prefix configuration parameter to 'my_db_prefix'", function() {
            process.env.DB_PREFIX = 'my_db_prefix';
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.DB_PREFIX).to.equal('my_db_prefix');
        });

        it('should set the database prefix configuration parameter to the default value if not set via DB_PREFIX', function() {
            delete process.env.DB_PREFIX;
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.DB_PREFIX).to.equal(DEFAULT_VALUES.DB_PREFIX);
        });

        it("should set the collection prefix configuration parameter to 'my_collection_prefix'", function() {
            process.env.COLLECTION_PREFIX = 'my_collection_prefix';
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.COLLECTION_PREFIX).to.equal('my_collection_prefix');
        });

        it('should set the collection prefix configuration parameter to the default value if not set via COLLECTION_PREFIX', function() {
            delete process.env.COLLECTION_PREFIX;
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.COLLECTION_PREFIX).to.equal(DEFAULT_VALUES.COLLECTION_PREFIX);
        });

        it("should set the database pool size configuration parameter to '10'", function() {
            process.env.POOL_SIZE = '10';
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.POOL_SIZE).to.equal(10);
        });

        it(
            'should set the database pool size configuration parameter to the default value if not set via ' +
                'POOL_SIZE',
            function() {
                delete process.env.POOL_SIZE;
                sthConfig = require(STH_CONFIGURATION_PATH);
                expect(sthConfig.POOL_SIZE).to.equal(DEFAULT_VALUES.POOL_SIZE);
            }
        );

        it('should set the database pool size configuration parameter to the default value if set to an invalid value', function() {
            process.env.POOL_SIZE = '-5';
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.POOL_SIZE).to.equal(DEFAULT_VALUES.POOL_SIZE);
        });

        it("should set the database write concern configuration parameter to '5'", function() {
            process.env.WRITE_CONCERN = '5';
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.WRITE_CONCERN).to.equal('5');
        });

        it(
            'should set the database write concern configuration parameter to the default value if not set via ' +
                'POOL_SIZE',
            function() {
                delete process.env.WRITE_CONCERN;
                sthConfig = require(STH_CONFIGURATION_PATH);
                expect(sthConfig.WRITE_CONCERN).to.equal(DEFAULT_VALUES.WRITE_CONCERN);
            }
        );

        it('should set the database write concern configuration parameter to the default value if set to an invalid value', function() {
            process.env.WRITE_CONCERN = 'ABC';
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.WRITE_CONCERN).to.equal(DEFAULT_VALUES.WRITE_CONCERN);
        });

        it("should set the database should store data configuration parameter to 'only-aggregated'", function() {
            process.env.SHOULD_STORE = 'only-aggregated';
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.SHOULD_STORE).to.equal('only-aggregated');
        });

        it(
            'should set the database should store data configuration parameter to the default value if not set via ' +
                'SHOULD_STORE',
            function() {
                delete process.env.SHOULD_STORE;
                sthConfig = require(STH_CONFIGURATION_PATH);
                expect(sthConfig.SHOULD_STORE).to.equal(DEFAULT_VALUES.SHOULD_STORE);
            }
        );

        it(
            'should set the database should store data configuration parameter to the default value if set to an invalid ' +
                'value',
            function() {
                process.env.SHOULD_STORE = 'only-whaaat?';
                sthConfig = require(STH_CONFIGURATION_PATH);
                expect(sthConfig.SHOULD_STORE).to.equal(DEFAULT_VALUES.SHOULD_STORE);
            }
        );

        it("should set the database truncation expiration time configuration parameter to '123456789'", function() {
            process.env.TRUNCATION_EXPIRE_AFTER_SECONDS = '123456789';
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.TRUNCATION_EXPIRE_AFTER_SECONDS).to.equal(123456789);
        });

        it(
            'should set the database truncation expiration time configuration parameter to the default value ' +
                'if not set via TRUNCATION_EXPIRE_AFTER_SECONDS',
            function() {
                delete process.env.TRUNCATION_EXPIRE_AFTER_SECONDS;
                sthConfig = require(STH_CONFIGURATION_PATH);
                expect(sthConfig.TRUNCATION_EXPIRE_AFTER_SECONDS).to.equal(
                    DEFAULT_VALUES.TRUNCATION_EXPIRE_AFTER_SECONDS
                );
            }
        );

        it(
            'should set the database truncation expiration time configuration parameter to the default value ' +
                'if set to an invalid value',
            function() {
                process.env.TRUNCATION_EXPIRE_AFTER_SECONDS = 'not-a-number';
                sthConfig = require(STH_CONFIGURATION_PATH);
                expect(sthConfig.TRUNCATION_EXPIRE_AFTER_SECONDS).to.equal(
                    DEFAULT_VALUES.TRUNCATION_EXPIRE_AFTER_SECONDS
                );
            }
        );

        it("should set the database truncation time configuration parameter to '987654321'", function() {
            process.env.TRUNCATION_SIZE = '987654321';
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.TRUNCATION_SIZE).to.equal(987654321);
        });

        it(
            'should set the database truncation size configuration parameter to the default value ' +
                'if not set via TRUNCATION_SIZE',
            function() {
                delete process.env.TRUNCATION_SIZE;
                sthConfig = require(STH_CONFIGURATION_PATH);
                expect(sthConfig.TRUNCATION_SIZE).to.equal(DEFAULT_VALUES.TRUNCATION_SIZE);
            }
        );

        it(
            'should set the database truncation size configuration parameter to the default value ' +
                'if set to an invalid value',
            function() {
                process.env.TRUNCATION_SIZE = 'not-a-number';
                sthConfig = require(STH_CONFIGURATION_PATH);
                expect(sthConfig.TRUNCATION_SIZE).to.equal(DEFAULT_VALUES.TRUNCATION_SIZE);
            }
        );

        it("should set the database truncation document number configuration parameter to '12345'", function() {
            process.env.TRUNCATION_MAX = '12345';
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.TRUNCATION_MAX).to.equal(12345);
        });

        it(
            'should set the database truncation document number configuration parameter to the default value ' +
                'if not set via TRUNCATION_MAX',
            function() {
                delete process.env.TRUNCATION_MAX;
                sthConfig = require(STH_CONFIGURATION_PATH);
                expect(sthConfig.TRUNCATION_MAX).to.equal(DEFAULT_VALUES.TRUNCATION_MAX);
            }
        );

        it(
            'should set the database truncation size configuration parameter to the default value ' +
                'if set to an invalid value',
            function() {
                process.env.TRUNCATION_MAX = 'not-a-number';
                sthConfig = require(STH_CONFIGURATION_PATH);
                expect(sthConfig.TRUNCATION_MAX).to.equal(DEFAULT_VALUES.TRUNCATION_MAX);
            }
        );

        it("should set the database ignore blank spaces configuration parameter to 'false'", function() {
            process.env.IGNORE_BLANK_SPACES = 'false';
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.IGNORE_BLANK_SPACES).to.equal(false);
        });

        it(
            'should set the database ignore blank spaces configuration parameter to the default value ' +
                'if not set via IGNORE_BLANK_SPACES',
            function() {
                delete process.env.IGNORE_BLANK_SPACES;
                sthConfig = require(STH_CONFIGURATION_PATH);
                expect(sthConfig.IGNORE_BLANK_SPACES).to.equal(DEFAULT_VALUES.IGNORE_BLANK_SPACES);
            }
        );

        it(
            'should set the database ignore blank spaces configuration parameter to the default value ' +
                'if set to an invalid value',
            function() {
                process.env.IGNORE_BLANK_SPACES = 'not-false';
                sthConfig = require(STH_CONFIGURATION_PATH);
                expect(sthConfig.IGNORE_BLANK_SPACES).to.equal(DEFAULT_VALUES.IGNORE_BLANK_SPACES);
            }
        );

        it("should set the database name encoding configuration parameter to 'false'", function() {
            process.env.NAME_ENCODING = 'false';
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.NAME_ENCODING).to.equal(false);
        });

        it(
            'should set the database name encoding configuration parameter to the default value ' +
                'if not set via NAME_ENCODING',
            function() {
                delete process.env.NAME_ENCODING;
                sthConfig = require(STH_CONFIGURATION_PATH);
                expect(sthConfig.NAME_ENCODING).to.equal(DEFAULT_VALUES.NAME_ENCODING);
            }
        );

        it(
            'should set the database name encoding configuration parameter to the default value ' +
                'if set to an invalid value',
            function() {
                process.env.NAME_ENCODING = 'not-false';
                sthConfig = require(STH_CONFIGURATION_PATH);
                expect(sthConfig.NAME_ENCODING).to.equal(DEFAULT_VALUES.NAME_ENCODING);
            }
        );

        it("should set the proof of life interval configuration parameter to '120'", function() {
            process.env.PROOF_OF_LIFE_INTERVAL = '120';
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.PROOF_OF_LIFE_INTERVAL).to.equal(120);
        });

        it(
            'should set the proof of life interval configuration parameter to the default value if not set via ' +
                'PROOF_OF_LIFE_INTERVAL',
            function() {
                delete process.env.PROOF_OF_LIFE_INTERVAL;
                sthConfig = require(STH_CONFIGURATION_PATH);
                expect(sthConfig.PROOF_OF_LIFE_INTERVAL).to.equal(DEFAULT_VALUES.PROOF_OF_LIFE_INTERVAL);
            }
        );

        it(
            'should set the proof of life interval configuration parameter to the default value if not set to a valid ' +
                'number',
            function() {
                process.env.PROOF_OF_LIFE_INTERVAL = 'ABC';
                sthConfig = require(STH_CONFIGURATION_PATH);
                expect(sthConfig.PROOF_OF_LIFE_INTERVAL).to.equal(DEFAULT_VALUES.PROOF_OF_LIFE_INTERVAL);
            }
        );

        it("should set the processed request log statistics interval configuration parameter to '120'", function() {
            process.env.PROCESSED_REQUEST_LOG_STATISTICS_INTERVAL = '120';
            sthConfig = require(STH_CONFIGURATION_PATH);
            expect(sthConfig.PROCESSED_REQUEST_LOG_STATISTICS_INTERVAL).to.equal(120);
        });

        it(
            'should set the processed request log statistics interval configuration parameter to the default value if not set via ' +
                'PROCESSED_REQUEST_LOG_STATISTICS_INTERVAL',
            function() {
                delete process.env.PROCESSED_REQUEST_LOG_STATISTICS_INTERVAL;
                sthConfig = require(STH_CONFIGURATION_PATH);
                expect(sthConfig.PROCESSED_REQUEST_LOG_STATISTICS_INTERVAL).to.equal(
                    DEFAULT_VALUES.PROCESSED_REQUEST_LOG_STATISTICS_INTERVAL
                );
            }
        );

        it(
            'should set the processed request log statistics interval configuration parameter to the default value if not set to a valid ' +
                'number',
            function() {
                process.env.PROCESSED_REQUEST_LOG_STATISTICS_INTERVAL = 'ABC';
                sthConfig = require(STH_CONFIGURATION_PATH);
                expect(sthConfig.PROCESSED_REQUEST_LOG_STATISTICS_INTERVAL).to.equal(
                    DEFAULT_VALUES.PROCESSED_REQUEST_LOG_STATISTICS_INTERVAL
                );
            }
        );
    });
});
