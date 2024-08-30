part of 'detail_page.dart';

buildBasic(BuildContext context, Aria2ServerConfig config) {
  return FormGroup(
    itemBuilder: (context, formItem) => DefaultFormItem(
      item: formItem,
      onConfirm: (item, value) {
        item.onChange?.call(value);
        Aria2RpcClient.instance
            .changeGlobalOption(item.key, value.toString())
            .then((result) {
              debugPrint(result.success.toString());
          if (result.success) {
            if (item.value is int) {
              item.value = int.parse(value.toString());
            } else if (item.value is double) {
              item.value = double.parse(value.toString());
            } else {
              item.value = value;
            }
          } else {
            Util.showErrorToast(S.of(context).connect_error);
          }
        });
      },
    ),
    title: S.of(context).basic,
    style: FormGroupStyle(
      backgroundColor: Theme.of(context).splashColor,
      collapsedBackgroundColor: Theme.of(context).highlightColor,
      textColor: Theme.of(context).primaryColor,
      elevation: 3,
    ),
    expanded: false,
    leading: CircleAvatar(
      backgroundColor: Colors.lightGreen,
      child: Text(
        S.of(context).basic[0],
        style: const TextStyle(color: Colors.white),
      ),
    ),
    items: [
      FormItem<String>(type: FormItemType.input, value: config.dir, key: 'dir'),
      FormItem<String>(
        type: FormItemType.input,
        value: config.log,
        key: 'log',
      ),
      FormItem<int>(
          type: FormItemType.input,
          value: config.maxConcurrentDownloads,
          key: 'max-concurrent-downloads'),
      FormItem<bool>(
        //
        type: FormItemType.switch_,
        value: config.checkIntegrity,
        key: 'check-integrity',
      ),
      FormItem<bool>(
        type: FormItemType.switch_,
        value: config.continueDownload,
        key: 'continue-download',
        showDivider: false,
      ),
    ],
  );
}
