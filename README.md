设计同步系统需要考虑
  客户端通过网络请求的方式 将用户数据通过使用 云数据库方式存储用户的数据,从而允许应⽤在不同的设备和操作系统版本上⽆ 缝同步⽤户的数据，通常有get和post两种方式，get是将网络的数据同步到本地进行存储，当离线网络的时候，通过读取本地存储的数据来进行数据的展示，，本地存储可以通过本地数据库的存储方式将get到的网络数据进行存储
图片数据的话可以通过缓存图片，不通的系统的设备可能尺寸大小都存在差异，可以通过特定的参数的方式向服务端请求相应的数据，来解决不通设备图片的大小和相应资源的不一致性问题，当网络不好的情况下，客户端可以通过设置超时的时间，当网络不好的时候给予用户友好的提示，通常为了快速的传输数据的话，通常使用json格式的数据进行传递，来提高网络效率，在遇到数据冲突，可以特定的标识进行区分，通过特定的方式进行刷选过滤，解决冗余数据和数据不符合业务需求的情况
