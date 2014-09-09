Delayed::Worker.destroy_failed_jobs = false
Delayed::Worker.max_run_time = 80.hours
Delayed::Worker.max_attempts = 0

#Delayed::Worker.sleep_delay = 60
#Delayed::Worker.read_ahead = 10
#Delayed::Worker.default_queue_name = 'default'
#Delayed::Worker.delay_jobs = !Rails.env.test?