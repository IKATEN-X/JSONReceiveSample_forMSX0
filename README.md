# JSONReceiveSample_forMSX0
MSX0でJSONデータを受信してBASICで使用するサンプルです。  

MSX0のHTTP通信のサンプルをベースに、JSONを受信するようにしています。  
JSONデータの解析と値の取得は、[MSX JSON Parser](https://github.com/ricbit/msxjson)を利用していて、その中のJSON.BINが必要となります。  

本サンプルは、BASICであまり大きなメモリが使用できないので、小さな天気用法データがを取得できる[Open-Meteo](https://open-meteo.com/)を利用しています。  
JSONで得たいデータは[「URL Builder」公式エディタ](https://open-meteo.com/en/docs)で組み立てることができます。  
具体的な使い方などは[こちら](https://paiza.hatenablog.com/entry/2021/11/04/130000)をご覧いただくのが早いかと思います。  
  
またMSX0の不具合なのか、リクエストの方法が間違っているのか、MSX0起動後、最初のHTTPリクエストが失敗します。  
一応リカバリ処理は入れていますのでエラーにはならない様にしています。  
