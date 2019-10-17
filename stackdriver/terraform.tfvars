# Common
project    = "corebox-001-244109"
subnetwork = "subnet-a"

# Notification info
channel_name  = "notification"
channel_type  = "email"
email_address = "paolo@corebox.co.uk"

# Alarms parameters
alignment_period          = "60s"
uptime_aligner            = "ALIGN_DELTA"
cpu_aligner               = "ALIGN_MAX"
cpu_alter_max_threshold   = "0.8"
cpu_max_theshold_duration = "60s"