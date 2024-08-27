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
          type: FormItemType.input, value: config.ftpUser, key: 'ftp-user'),
      //FTP 默认密码(ftp-passwd)
      FormItem<String>(
        type: FormItemType.input,
        value: config.ftpPasswd,
        key: 'ftp-passwd',
      ),
      //被动模式(ftp-pasv)
      FormItem<bool>(
        type: FormItemType.switch_,
        value: config.ftpPassive,
        key: 'ftp-pasv',
      ),
      //FTP 代理服务器(ftp-proxy)
      FormItem<String>(
          type: FormItemType.input, value: config.ftpProxy, key: 'ftp-proxy'),
      //FTP 代理服务器用户名(ftp-proxy-user)
      FormItem<String>(
          type: FormItemType.input,
          value: config.ftpProxyUser,
          key: 'ftp-proxy-user'),
      //FTP 代理服务器密码(ftp-proxy-passwd)
      FormItem<String>(
          type: FormItemType.input,
          value: config.ftpProxyPasswd,
          key: 'ftp-proxy-passwd'),
      //传输类型(ftp-type)
      FormItem<String>(
        type: FormItemType.select,
        value: config.ftpType,
        key: 'ftp-type',
        options: [
          FormItemOption(label: "BINARY", value: "binary"),
          FormItemOption(label: "ASCII", value: "ascii"),
        ],
      ),
      //连接复用(ftp-reuse-connection)
      FormItem<bool>(
        type: FormItemType.switch_,
        value: config.ftpReuseConnection,
        key: 'ftp-reuse-connection',
      ),
      //SSH 公钥校验和(ssh-host-key-md)
      FormItem<String>(
        type: FormItemType.input,
        value: config.sshHostKeyMD,
        key: 'ssh-host-key-md',
        showDivider: false,
      ),
    ],
  );
}
