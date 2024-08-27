part of 'detail_page.dart';

buildMetaLink(BuildContext context, Aria2ServerConfig config) {
  return FormGroup(
    title: 'Metalink',
    style: FormGroupStyle(
      backgroundColor: Theme.of(context).splashColor,
      collapsedBackgroundColor: Theme.of(context).highlightColor,
      textColor: Theme.of(context).primaryColor,
      elevation: 3,
    ),
    leading: const CircleAvatar(
      backgroundColor: Colors.lightGreen,
      child: Text(
        'M',
        style: TextStyle(color: Colors.white),
      ),
    ),
    items: [
      //下载 Metalink 中的文件(follow-metalink) tooltip:'如果设置为"是"或"仅内存", 当后缀为 .meta4 或 .metalink 或内容类型为 application/metalink4+xml 或 application/metalink+xml 的文件下载完成时, aria2 将按 Metalink 文件读取并下载该文件中提到的文件. 如果设置为"仅内存", 该 Metalink 文件将不会写入到磁盘中, 而仅会存储在内存中. 如果设置为"否", 则 .metalink 文件会下载到磁盘中, 但不会按 Metalink 文件读取并且其中的文件不会进行下载.'
      FormItem<bool>(
        type: FormItemType.switch_,
        value: config.followMetaLink,
        key: 'follow-metalink',
      ),
      //基础 URI(metalink-base-uri) tooltip:'指定基础 URI 以便解析本地磁盘中存储的 Metalink 文件里 metalink:url 和 metalink:metaurl 中的相对 URI 地址. 如果 URI 表示的为目录, 最后需要以 / 结尾.'
      FormItem<String>(
        type: FormItemType.input,
        value: config.metalinkBaseUrl,
        key: 'metalink-base-uri',
      ),
      //语言(metalink-language)
      FormItem<String>(
        type: FormItemType.input,
        value: config.metalinkLanguage,
        key: 'metalink-language',
      ),
      //首选服务器位置(metalink-location) tooltip:'首选服务器所在的位置. 可以使用逗号分隔的列表, 例如: jp,us.'
      FormItem<String>(
        type: FormItemType.input,
        value: config.metalinkLocation,
        key: 'metalink-location',
      ),
      //操作系统(metalink-os) tooltip:'下载文件的操作系统.'
      FormItem<String>(
        type: FormItemType.input,
        value: config.metalinkOs,
        key: 'metalink-os',
      ),
      //版本号(metalink-version) tooltip:'下载文件的版本号.'
      FormItem<String>(
        type: FormItemType.input,
        value: config.metalinkVersion,
        key: 'metalink-version',
      ),
      //首选使用协议(metalink-preferred-protocol) tooltip:'指定首选使用的协议. 可以设置为 http, https, ftp 或"无". 设置为"无"时禁用此选项.'
      FormItem<String>(
        type: FormItemType.select,
        value: config.metalinkPreferredProtocol,
        key: 'metalink-preferred-protocol',
        options: [
          FormItemOption(label: "HTTP", value: "http"),
          FormItemOption(label: "HTTPS", value: "https"),
          FormItemOption(label: "FTP", value: "ftp"),
          FormItemOption(label: "无", value: "none"),
        ],
      ),
      //仅使用唯一协议(metalink-enable-unique-protocol) tooltip:'如果一个 Metalink 文件可用多种协议, 并且此选项设置为"是", aria2 将只会使用其中一种. 使用 --metalink-preferred-protocol 参数指定首选的协议.'
      FormItem<bool>(
        type: FormItemType.switch_,
        value: config.metalinkEnableUniqueProtocol,
        key: 'metalink-enable-unique-protocol',
        showDivider: false,
      ),
    ],
  );
}
