part of 'detail_page.dart';

buildBasic(BuildContext context, Aria2ServerConfig config) {
  return FormGroup(
      title: '基本设置',
      style: FormGroupStyle(
        backgroundColor: Theme.of(context).splashColor,
        collapsedBackgroundColor: Theme.of(context).highlightColor,
        textColor: Theme.of(context).primaryColor,
        elevation: 3,
      ),
      expanded: true,
      leading: const CircleAvatar(
        backgroundColor: Colors.lightGreen,
        child: Text(
          '基',
          style: TextStyle(color: Colors.white),
        ),
      ),
      items: [
        FormItem<String>(
            label: '下载路径',
            type: FormItemType.input,
            value: config.dir,
            key: 'dir'),
        FormItem<String>(
            label: '日志文件',
            type: FormItemType.input,
            value: config.log,
            key: 'log',
            tooltip:
                "日志文件的路径. 如果设置为 &quot;-&quot;, 日志则写入到 stdout. 如果设置为空字符串(&quot;&quot;), 日志将不会记录到磁盘上."),
        FormItem<int>(
            label: '最大同时下载数',
            type: FormItemType.input,
            value: config.maxConcurrentDownloads,
            key: 'max-concurrent-downloads'),
        FormItem<bool>(
            label: '检查完整性',
            type: FormItemType.switch_,
            value: config.checkIntegrity,
            key: 'check-integrity',
            tooltip:
                "通过对文件的每个分块或整个文件进行哈希验证来检查文件的完整性. 此选项仅对BT、Metalink及设置了 --checksum 选项的 HTTP(S)/FTP 链接生效."),
        FormItem<bool>(
            label: '断点续传',
            type: FormItemType.switch_,
            value: config.continueDownload,
            key: 'continue-download',
            showDivider: false,
            tooltip:
                "继续下载部分完成的文件. 启用此选项可以继续下载从浏览器或其他程序按顺序下载的文件. 此选项目前只支持 HTTP(S)/FTP 下载的文件."),
      ],
      itemBuilder: (context, item) {
        return OptionItem(
          formItem: item,
        );
      });
}
