part of 'detail_page.dart';

buildHttp(BuildContext context, Aria2ServerConfig config) {
  return FormGroup(
      title: 'HTTP',
      style: FormGroupStyle(
        backgroundColor: Theme.of(context).splashColor,
        collapsedBackgroundColor: Theme.of(context).highlightColor,
        textColor: Theme.of(context).primaryColor,
        elevation: 3,
      ),
      leading: const CircleAvatar(
          backgroundColor: Colors.lightGreen,
          child: Text(
            'H',
            style: TextStyle(color: Colors.white),
          )),
      items: [
        //检查证书(check-certificate)
        FormItem<bool>(
            label: '检查证书',
            type: FormItemType.switch_,
            value: config.checkCertificate,
            key: 'check-certificate',
            tooltip:
                "如果远程服务器的响应头中包含 Content-Encoding: gzip 或 Content-Encoding: deflate , 将发送包含 Accept: deflate, gzip 的请求头并解压缩响应."),
        //支持 GZip(http-accept-gzip) tooltip:'如果远程服务器的响应头中包含 Content-Encoding: gzip 或 Content-Encoding: deflate , 将发送包含 Accept: deflate, gzip 的请求头并解压缩响应.'
        FormItem<bool>(
            label: '支持 GZip',
            type: FormItemType.switch_,
            value: config.httpAcceptGZip,
            key: 'http-accept-gzip',
            tooltip:
                "如果远程服务器的响应头中包含 Content-Encoding: gzip 或 Content-Encoding: deflate , 将发送包含 Accept: deflate, gzip 的请求头并解压缩响应."),
        //认证质询(http-auth-challenge) tooltip:'仅当服务器需要时才发送 HTTP 认证请求头. 如果设置为"否", 每次都会发送认证请求头. 例外: 如果用户名和密码包含在 URI 中, 将忽略此选项并且每次都会发送认证请求头.'
        FormItem<bool>(
            label: '认证质询',
            type: FormItemType.switch_,
            value: config.httpAuthChallenge,
            key: 'http-auth-challenge',
            tooltip:
                "仅当服务器需要时才发送 HTTP 认证请求头. 如果设置为\"否\", 每次都会发送认证请求头. 例外: 如果用户名和密码包含在 URI 中, 将忽略此选项并且每次都会发送认证请求头."),
        //禁用缓存(http-no-cache) tooltip:'发送的请求头中将包含 Cache-Control: no-cache 和 Pragma: no-cache header 以避免内容被缓存. 如果设置为"否", 上述请求头将不会发送, 同时您也可以使用 --header 选项将 Cache-Control 请求头添加进去.'
        FormItem<bool>(
            label: '禁用缓存',
            type: FormItemType.switch_,
            value: config.httpNoCache,
            key: 'http-no-cache',
            tooltip:
                "发送的请求头中将包含 Cache-Control: no-cache 和 Pragma: no-cache header 以避免内容被缓存. 如果设置为\"否\", 上述请求头将不会发送, 同时您也可以使用 --header 选项将 Cache-Control 请求头添加进去."),
        //HTTP 默认用户名(http-user)
        FormItem<String>(
          label: 'HTTP 默认用户名',
          type: FormItemType.input,
          value: config.httpUser,
          key: 'http-user',
        ),
        //HTTP 默认密码(http-passwd)
        FormItem<String>(
          label: 'HTTP 默认密码',
          type: FormItemType.input,
          value: config.httpPasswd,
          key: 'http-passwd',
        ),
        //HTTP 代理服务器(http-proxy)
        FormItem<String>(
          label: 'HTTP 代理服务器',
          type: FormItemType.input,
          value: config.httpProxy,
          key: 'http-proxy',
        ),
        //HTTP 代理服务器用户名(http-proxy-user)
        FormItem<String>(
          label: 'HTTP 代理服务器用户名',
          type: FormItemType.input,
          value: config.httpProxyUser,
          key: 'http-proxy-user',
        ),
        //HTTP 代理服务器密码(http-proxy-passwd)
        FormItem<String>(
          label: 'HTTP 代理服务器密码',
          type: FormItemType.input,
          value: config.httpProxyPasswd,
          key: 'http-proxy-passwd',
        ),
        //HTTPS 代理服务器(https-proxy)
        FormItem<String>(
          label: 'HTTPS 代理服务器',
          type: FormItemType.input,
          value: config.httpsProxy,
          key: 'https-proxy',
        ),
        //HTTPS 代理服务器用户名(https-proxy-user)
        FormItem<String>(
          label: 'HTTPS 代理服务器用户名',
          type: FormItemType.input,
          value: config.httpsProxyUser,
          key: 'https-proxy-user',
        ),
        //HTTPS 代理服务器密码(https-proxy-passwd)
        FormItem<String>(
          label: 'HTTPS 代理服务器密码',
          type: FormItemType.input,
          value: config.httpsProxyPasswd,
          key: 'https-proxy-passwd',
        ),
        //请求来源(referer) tooltip:'设置 HTTP 请求来源 (Referer). 此选项将影响所有 HTTP/HTTPS 下载. 如果设置为 *, 请求来源将设置为下载链接. 此选项可以配合 --parameterized-uri 选项使用.'
        FormItem<String>(
            label: '请求来源',
            type: FormItemType.input,
            value: config.referer,
            key: 'referer',
            tooltip:
                "设置 HTTP 请求来源 (Referer). 此选项将影响所有 HTTP/HTTPS 下载. 如果设置为 *, 请求来源将设置为下载链接. 此选项可以配合 --parameterized-uri 选项使用."),
        //启用持久连接(enable-http-keep-alive) tooltip:'启用 HTTP/1.1 持久连接.'
        FormItem<bool>(
            label: '启用持久连接',
            type: FormItemType.switch_,
            value: config.enableHttpKeepAlive,
            key: 'enable-http-keep-alive',
            tooltip: "启用 HTTP/1.1 持久连接."),
        //启用 HTTP 管线化(enable-http-pipelining) tooltip:'启用 HTTP/1.1 管线化.'
        FormItem<bool>(
            label: '启用 HTTP 管线化',
            type: FormItemType.switch_,
            value: config.enableHttpPipelining,
            key: 'enable-http-pipelining',
            tooltip: "启用 HTTP/1.1 管线化."),
        //自定义请求头(header) tooltip:'增加 HTTP 请求头内容. 每行放置一项, 每项包含 "请求头名: 请求头值".'
        FormItem<String>(
            label: '自定义请求头',
            type: FormItemType.input,
            value: config.header,
            key: 'header',
            tooltip: "增加 HTTP 请求头内容. 每行放置一项, 每项包含 \"请求头名: 请求头值\"."),
        //Cookies 保存路径(save-cookies) tooltip:'以 Mozilla/Firefox(1.x/2.x)/Netscape 格式将 Cookies 保存到文件中. 如果文件已经存在, 将被覆盖. 会话过期的 Cookies 也将会保存, 其过期时间将会设置为 0.'
        FormItem<String>(
            label: 'Cookies 保存路径',
            type: FormItemType.input,
            value: config.saveCookies,
            key: 'save-cookies',
            tooltip:
                "以 Mozilla/Firefox(1.x/2.x)/Netscape 格式将 Cookies 保存到文件中. 如果文件已经存在, 将被覆盖. 会话过期的 Cookies 也将会保存, 其过期时间将会设置为 0."),
        //启用 HEAD 方法(use-head) tooltip:'第一次请求 HTTP 服务器时使用 HEAD 方法.'
        FormItem<bool>(
            label: '启用 HEAD 方法',
            type: FormItemType.switch_,
            value: config.useHead,
            key: 'use-head',
            tooltip: "第一次请求 HTTP 服务器时使用 HEAD 方法."),
        //自定义 User Agent(user-agent)
        FormItem<String>(
            label: '自定义 User Agent',
            type: FormItemType.input,
            value: config.userAgent,
            key: 'user-agent',
            showDivider: false),
      ],
      itemBuilder: (BuildContext context, FormItem<dynamic> item) {
        return OptionItem(
          formItem: item,
        );
      });
}
