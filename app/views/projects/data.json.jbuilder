
json.readings @readings, :timestamp, :value1, :value2

json.connected !!(@status ? @status.is_connect : false)