###redis##config########
redis.num=2
#redis1服务器ip #
redis0.ip=10.37.253.74
redis1.ip=10.37.253.74

#redis服务器端口号#
redis0.port=6378
redis1.port=6379

###jedis##pool##config###
#jedis的最大分配对象#
redis.pool.maxActive=1024

#jedis最大保存idel状态对象数 #
redis.pool.maxIdle=200

#jedis池没有对象返回时，最大等待时间 #
redis.pool.maxWait=10000

#jedis调用borrowObject方法时，是否进行有效检查#
redis.pool.testOnBorrow=true

#jedis调用returnObject方法时，是否进行有效检查 #
redis.pool.testOnReturn=true


manager.shiro.jsid=dev_jsid