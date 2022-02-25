ruleset temperature_store {

    meta {
        provides temperatures, threshold_violations, inrange_temperatures
        shares temperatures, threshold_violations, inrange_temperatures
    }

    // Define global variables
    global {
        temperatures = function() {
            ent:temp_storage
        }

        threshold_violations = function() {
            ent:temp_violation_storage
        }

        inrange_temperatures = function() {
            // Filter temperatures from temp_storage based on if in temp_violation_storage
            good_temps = ent:temp_storage.filter(function(v,k) {
                value = ent:temp_violation_storage{k}
                value == null
            })

            good_temps
        }
    }

    rule collect_temperatures {
        // Define when the rule is selected
        select when wovyn new_temperature_reading

        // Get variables from the event
        pre {
            passed_temperature = event:attrs{"temperature"}.klog("Received the following temperature in Temp_store: ")
            passed_timestamp = event:attrs{"timestamp"}.klog("Received the following time in Temp_store: ")
        }

        // Postlude
        always {
            ent:temp_storage := ent:temp_storage.defaultsTo({}, "initializtion was needed for temps");
            ent:temp_storage{[passed_timestamp, "temperature"]} := passed_temperature
        }

    }

    rule collect_threshold_violations {
        // Define when the rule is selected
        select when wovyn threshold_violation

        // Get variables from the event
        pre {
            passed_temperature = event:attrs{"temperature"}
            passed_timestamp = event:attrs{"timestamp"}
        }

        always {
            ent:temp_violation_storage := ent:temp_violation_storage.defaultsTo({}, "initializtion was needed for violation");
            ent:temp_violation_storage{[passed_timestamp, "temperature"]} := passed_temperature
        }
    }

    rule clear_temperatures {
        select when sensor reading_reset

        always {
            ent:temp_storage := {}
            ent:temp_violation_storage := {}
        }
    }
}