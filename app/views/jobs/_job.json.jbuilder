json.extract! job, :id, :jobNum, :poDate, :customer, :description, :needBom, :bomDone, :status, :progress, :priority, :created_at, :updated_at
json.url job_url(job, format: :json)
