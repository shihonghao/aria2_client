part of 'detail_page.dart';

buildSFTP(BuildContext context, Aria2ServerConfig config) {
  return FormGroup(
      title: 'FTP/SFTP',
      style: FormGroupStyle(
        backgroundColor: Theme.of(context).splashColor,
        collapsedBackgroundColor: Theme.of(context).highlightColor,
        textColor: Theme.of(context).primaryColor,
        elevation: 3,
      ),
      leading: const CircleAvatar(
        backgroundColor: Colors.lightGreen,
        child: Text(
          'F',
          style: TextStyle(color: Colors.white),
        ),
      ),
      items: [
        //FTP 默认用户名(ftp-user)
        FormItem<String>(
            label: '用户名',
            type: FormItemType.input,
            value: config.ftpUser,
            key: 'ftp-user'),
        //FTP 默认密码(ftp-passwd) tooltip:'如果 URI 中包含用户名单不包含密码, aria2 首先会从 .netrc 文件中获取密码. 如果在 .netrc 文件中找到密码, 则使用该密码. 否则, 使用此选项设置的密码.'
        FormItem<String>(
            label: '密码',
            type: FormItemType.input,
            value: config.ftpPasswd,
            key: 'ftp-passwd',
            tooltip:
                '如果 URI 中包含用户名和密码, aria2 首先会从 .netrc 文件中获取密码. 如果在 .netrc 文件中找到密码, 则使用该密码. 否则, 使用此选项设置的密码.'),
        //被动模式(ftp-pasv) tooltip:'在 FTP 中使用被动模式. 如果设置为"否", 则使用主动模式. 此选项不适用于 SFTP 传输.'
        FormItem<bool>(
            label: '被动模式',
            type: FormItemType.switch_,
            value: config.ftpPassive,
            key: 'ftp-pasv',
            tooltip: '在 FTP 中使用被动模式. 如果设置为"否", 则使用主动模式. 此选项不适用于 SFTP 传输.'),
        //FTP 代理服务器(ftp-proxy)
        FormItem<String>(
            label: 'FTP 代理服务器',
            type: FormItemType.input,
            value: config.ftpProxy,
            key: 'ftp-proxy'),
        //FTP 代理服务器用户名(ftp-proxy-user)
        FormItem<String>(
            label: 'FTP 代理服务器用户名',
            type: FormItemType.input,
            value: config.ftpProxyUser,
            key: 'ftp-proxy-user'),
        //FTP 代理服务器密码(ftp-proxy-passwd)
        FormItem<String>(
            label: 'FTP 代理服务器密码',
            type: FormItemType.input,
            value: config.ftpProxyPasswd,
            key: 'ftp-proxy-passwd'),
        //传输类型(ftp-type)
        FormItem<String>(
            label: '传输类型',
            type: FormItemType.select,
            value: config.ftpType,
            key: 'ftp-type',
            options: [
              FormItemOption(label: "二进制", value: "binary"),
              FormItemOption(label: "ASCII", value: "ascii"),
            ],
            tooltip:
                '设置 FTP 传输类型. 此选项仅对 FTP 传输生效. 可选值: "active" 或 "passive". 默认值: "active".'),
        //连接复用(ftp-reuse-connection)
        FormItem<bool>(
            label: '连接复用',
            type: FormItemType.switch_,
            value: config.ftpReuseConnection,
            key: 'ftp-reuse-connection',
            tooltip: '设置是否复用 FTP 连接. 此选项仅对 FTP 传输生效. 默认值: "否".'),
        //SSH 公钥校验和(ssh-host-key-md) tooltip:'设置 SSH 主机公钥的校验和. 选项值格式为 TYPE=DIGEST. TYPE 为哈希类型. 支持的哈希类型为 sha-1 和 md5. DIGEST 是十六进制摘要. 例如: sha-1=b030503d4de4539dc7885e6f0f5e256704edf4c3. 此选项可以在使用 SFTP 时用来验证服务器的公钥. 如果此选项不设置, 即保留默认, 不会进行任何验证。'
        FormItem<String>(
            label: 'SSH 公钥校验和',
            type: FormItemType.input,
            value: config.sshHostKeyMD,
            key: 'ssh-host-key-md',
            showDivider: false,
            tooltip:
                '设置 SSH 主机公钥的校验和. 选项值格式为 TYPE=DIGEST. TYPE 为哈希类型. 支持的哈希类型为 sha-1 和 md5. DIGEST 是十六进制摘要. 例如: sha-1=b030503d4de4539dc7885e6f0f5e256704edf4c3. 此选项可以在使用 SFTP 时用来验证服务器的公钥. 如果此选项不设置, 即保留默认, 不会进行任何验证。'),
      ],
      itemBuilder: (context, item) {
        return OptionItem(
          formItem: item,
        );
      });
}
