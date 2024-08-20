part of 'detail_page.dart';

buildAdvanced(BuildContext context, Aria2ServerConfig config) {
  return FormGroup(
      title: '高级',
      style: FormGroupStyle(
        backgroundColor: Theme.of(context).splashColor,
        collapsedBackgroundColor: Theme.of(context).highlightColor,
        textColor: Theme.of(context).primaryColor,
        elevation: 3,
      ),
      leading: const CircleAvatar(
        backgroundColor: Colors.lightGreen,
        child: Text(
          '高',
          style: TextStyle(color: Colors.white),
        ),
      ),
      items: [
        //允许覆盖(allow-overwrite) tooltip:'如果相应的控制文件不存在时从头重新下载文件. 参见 --auto-file-renaming 选项.'
        FormItem<bool>(
          label: '允许覆盖',
          type: FormItemType.switch_,
          value: config.allowOverwrite,
          key: 'allow-overwrite',
          tooltip: "如果相应的控制文件不存在时从头重新下载文件. 参见 --auto-file-renaming 选项.",
        ),
        //允许分片大小变化(allow-piece-length-change) tooltip:'如果设置为"否", 当分片长度与控制文件中的不同时, aria2 将会中止下载. 如果设置为"是", 您可以继续, 但部分下载进度将会丢失.'
        FormItem<bool>(
          label: '允许分片大小变化',
          type: FormItemType.switch_,
          value: config.allowPieceLengthChange,
          key: 'allow-piece-length-change',
          tooltip:
              "如果设置为\"否\", 当分片长度与控制文件中的不同时, aria2 将会中止下载. 如果设置为\"是\", 您可以继续, 但部分下载进度将会丢失.",
        ),
        //始终断点续传(always-resume) tooltip:'始终断点续传. 如果设置为"是", aria2 始终尝试断点续传, 如果无法恢复, 则中止下载. 如果设置为"否", 对于不支持断点续传的 URI 或 aria2 遇到 N 个不支持断点续传的 URI (N 为 --max-resume-failure-tries 选项设置的值), aria2 会从头下载文件. 参见 --max-resume-failure-tries 参数.'
        FormItem<bool>(
            label: '始终断点续传',
            type: FormItemType.switch_,
            value: config.alwaysResume,
            key: 'always-resume',
            tooltip:
                "始终断点续传. 如果设置为\"是\", aria2 始终尝试断点续传, 如果无法恢复, 则中止下载. 如果设置为\"否\", 对于不支持断点续传的 URI 或 aria2 遇到 N 个不支持断点续传的 URI (N为 --max-resume-failure-tries 选项设置的值), aria2 会从头下载文件. 参见 --max-resume-failure-tries 参数."),
        //异步 DNS(async-dns)
        FormItem<bool>(
          label: '异步 DNS',
          type: FormItemType.switch_,
          value: config.asyncDns,
          key: 'async-dns',
          tooltip:
              "异步 DNS. 如果设置为\"是\", aria2 将使用异步 DNS 查询域名. 如果设置为\"否\", aria2 将使用同步 DNS 查询域名. 此选项仅影响 HTTP(S)/FTP 下载.",
        ),
        //文件自动重命名(auto-file-renaming) tooltip:'重新命名已经存在的文件. 此选项仅对 HTTP(S)/FTP 下载有效. 新的文件名后会在文件名后、扩展名 (如果有) 前追加句点和数字(1..9999).'
        FormItem<bool>(
          label: '文件自动重命名',
          type: FormItemType.switch_,
          value: config.autoFileRenaming,
          key: 'auto-file-renaming',
          tooltip:
              "重新命名已经存在的文件. 此选项仅对 HTTP(S)/FTP 下载有效. 新的文件名后会在文件名后、扩展名 (如果有) 前追加句点和数字(1..9999).",
        ),
        //自动保存间隔(auto-save-interval) tooltip:'每隔设置的秒数自动保存控制文件(*.aria2). 如果设置为 0, 下载期间控制文件不会自动保存. 不论设置的值为多少, aria2 会在任务结束时保存控制文件. 可以设置的值为 0 到 600.'
        FormItem<int>(
            label: '自动保存间隔',
            type: FormItemType.input,
            value: config.autoSaveInterval,
            key: 'auto-save-interval',
            readOnly: true,
            tooltip:
                "每隔设置的秒数自动保存控制文件(*.aria2). 如果设置为 0, 下载期间控制文件不会自动保存. 不论设置的值为多少, aria2 会在任务结束时保存控制文件. 可以设置的值为 0 到 600.",
            trailingBuilder: (context) => buildUnitTrailing(context, "秒")),
        //条件下载(conditional-get) tooltip:'仅当本地文件比远程文件旧时才进行下载. 此功能仅适用于 HTTP(S) 下载. 如果在 Metalink 中文件大小已经被指定则功能无法生效. 同时此功能还将忽略 Content-Disposition 响应头. 如果存在控制文件, 此选项将被忽略. 此功能通过 If-Modified-Since 请求头获取较新的文件. 当获取到本地文件的修改时间时, 此功能将使用用户提供的文件名 (参见 --out 选项), 如果没有指定 --out 选项则使用 URI 中的文件名. 为了覆盖已经存在的文件, 需要使用 --allow-overwrite 参数.'
        FormItem<bool>(
            label: '条件下载',
            type: FormItemType.switch_,
            value: config.conditionalGet,
            key: 'conditional-get',
            tooltip:
                "仅当本地文件比远程文件旧时才进行下载. 此功能仅适用于 HTTP(S) 下载. 如果在 Metalink 中文件大小已经被指定则功能无法生效. 同时此功能还将忽略 Content-Disposition 响应头. 如果存在控制文件, 此选项将被忽略. 此功能通过 If-Modified-Since 请求头获取较新的文件. 当获取到本地文件的修改时间时, 此功能将使用用户提供的文件名 (参见 --out 选项), 如果没有指定 --out 选项则使用 URI 中的文件名. 为了覆盖已经存在的文件, 需要使用 --allow-overwrite 参数."),
        //配置文件路径(conf-path)
        FormItem<String>(
          label: '配置文件路径',
          type: FormItemType.input,
          value: config.confPath,
          key: 'conf-path',
          readOnly: true,
        ),
        //控制台日志级别(console-log-level)
        FormItem<String>(
          label: '控制台日志级别',
          type: FormItemType.input,
          value: config.consoleLogLevel,
          key: 'console-log-level',
          options: [
            FormItemOption(label: "DEBUG", value: "debug"),
            FormItemOption(label: "INFO", value: "info"),
            FormItemOption(label: "NOTICE", value: "notice"),
            FormItemOption(label: "WARN", value: "warn"),
            FormItemOption(label: "ERROR", value: "error"),
          ],
          readOnly: true,
        ),
        //使用 UTF-8 处理 Content-Disposition(content-disposition-default-utf8) tooltip:'处理 "Content-Disposition" 头中的字符串时使用 UTF-8 字符集来代替 ISO-8859-1, 例如, 文件名参数, 但不是扩展版本的文件名.'
        FormItem<bool>(
            label: '使用 UTF-8 处理 Content-Disposition',
            type: FormItemType.switch_,
            value: config.contentDispositionDefaultUtf8,
            key: 'content-disposition-default-utf8',
            tooltip:
                "处理 \"Content-Disposition\" 头中的字符串时使用 UTF-8 字符集来代替 ISO-8859-1, 例如, 文件名参数, 但不是扩展版本的文件名."),
        //启用后台进程(daemon)
        FormItem<bool>(
            label: '启用后台进程',
            type: FormItemType.switch_,
            value: config.daemon,
            key: 'daemon',
            readOnly: true,
            tooltip:
                "启用后台进程. 如果设置为\"是\", aria2 将在后台运行, 不会输出任何日志. 此选项仅影响控制台日志. 如果设置为\"否\", aria2 将在控制台输出日志. 此选项仅影响控制台日志."),
        //延迟加载(deferred-input) tooltip:'如果设置为"是", aria2 在启动时不会读取 --input-file 选项设置的文件中的所有 URI 地址, 而是会在之后需要时按需读取. 如果输入文件中包含大量要下载的 URI, 此选项可以减少内存的使用. 如果设置为"否", aria2 会在启动时读取所有的 URI. 当 -save-session 使用时将会禁用 --deferred-input 选项.'
        FormItem<bool>(
            label: '延迟加载',
            type: FormItemType.switch_,
            value: config.deferredInput,
            key: 'deferred-input',
            readOnly: true,
            tooltip:
                "如果设置为\"是\", aria2 在启动时不会读取 --input-file 选项设置的文件中的所有 URI 地址, 而是会在之后需要时按需读取. 如果输入文件中包含大量要下载的 URI, 此选项可以减少内存的使用. 如果设置为\"否\", aria2 会在启动时读取所有的 URI.当 -save-session 使用时将会禁用 --deferred-input 选项."),
        //禁用 IPv6(disable-ipv6)
        FormItem<bool>(
          label: '禁用 IPv6',
          type: FormItemType.switch_,
          value: config.disableIpv6,
          key: 'disable-ipv6',
          readOnly: true,
        ),
        //磁盘缓存(disk-cache) tooltip:'启用磁盘缓存. 如果设置为 0, 将禁用磁盘缓存. 此功能将下载的数据缓存在内存中, 最多占用此选项设置的字节数. 缓存存储由 aria2 实例创建并对所有下载共享. 由于数据以较大的单位写入并按文件的偏移重新排序, 所以磁盘缓存的一个优点是减少磁盘的 I/O. 如果调用哈希检查时并且数据缓存在内存中时, 将不需要从磁盘中读取. 大小可以包含 K 或 M (1K = 1024, 1M = 1024K).'
        FormItem<int>(
            label: '磁盘缓存',
            type: FormItemType.input,
            value: config.diskCache,
            key: 'disk-cache',
            readOnly: true,
            tooltip:
                "启用磁盘缓存. 如果设置为 0, 将禁用磁盘缓存. 此功能将下载的数据缓存在内存中, 最多占用此选项设置的字节数. 缓存存储由 aria2 实例创建并对所有下载共享. 由于数据以较大的单位写入并按文件的偏移重新排序, 所以磁盘缓存的一个优点是减少磁盘的 I/O. 如果调用哈希检查时并且数据缓存在内存中时, 将不需要从磁盘中读取. 大小可以包含 K 或 M (1K = 1024, 1M = 1024K)."),
        //下载结果(download-result) tooltip:'此选项将修改下载结果的格式. 如果设置为"默认", 将打印 GID, 状态, 平均下载速度和路径/URI. 如果涉及多个文件, 仅打印第一个请求文件的路径/URI, 其余的将被忽略. 如果设置为"完整", 将打印 GID, 状态, 平均下载速度, 下载进度和路径/URI. 其中, 下载进度和路径/URI 将会每个文件打印一行. 如果设置为"隐藏", 下载结果将会隐藏.'
        FormItem<String>(
          label: '下载结果',
          type: FormItemType.select,
          value: config.downloadResult,
          key: 'download-result',
          options: [
            FormItemOption(label: "默认", value: "default"),
            FormItemOption(label: "完整", value: "full"),
            FormItemOption(label: "隐藏", value: "hide"),
          ],
          tooltip:
              "此选项将修改下载结果的格式. 如果设置为\"默认\", 将打印 GID, 状态, 平均下载速度和路径/URI. 如果涉及多个文件, 仅打印第一个请求文件的路径/URI, 其余的将被忽略. 如果设置为\"完整\", 将打印GID, 状态, 平均下载速度, 下载进度和路径/URI. 其中, 下载进度和路径/URI 将会每个文件打印一行. 如果设置为\"隐藏\", 下载结果将会隐藏.",
        ),
        //DSCP(dscp) tooltip:'为 QoS 设置 BT 上行 IP 包的 DSCP 值. 此参数仅设置 IP 包中 TOS 字段的 DSCP 位, 而不是整个字段. 如果您从 /usr/include/netinet/ip.h 得到的值, 需要除以 4 (否则值将不正确, 例如您的 CS1 类将会转为 CS4). 如果您从 RFC, 网络供应商的文档, 维基百科或其他来源采取常用的值, 可以直接使用.'
        FormItem<int>(
            label: 'DSCP',
            type: FormItemType.input,
            value: config.dscp,
            key: 'dscp',
            readOnly: true,
            tooltip:
                "为 QoS 设置 BT 上行 IP 包的 DSCP 值. 此参数仅设置 IP 包中 TOS 字段的 DSCP 位, 而不是整个字段. 如果您从 /usr/include/netinet/ip.h 得到的值, 需要除以 4 (否则值将不正确, 例如您的 CS1 类将会转为 CS4). 如果您从 RFC, 网络供应商的文档, 维基opedia或其他来源采取常用的值, 可以直接使用."),
        //最多打开的文件描述符(rlimit-nofile) tooltip:'设置打开的文件描述符的软限制 (soft limit). 此选项仅当满足如下条件时开放: a. 系统支持它 (posix). b. 限制没有超过硬限制 (hard limit). c. 指定的限制比当前的软限制高. 这相当于设置 ulimit, 除了其不能降低限制. 此选项仅当系统支持 rlimit API 时有效.'
        FormItem<int>(
            label: '最多打开的文件描述符',
            type: FormItemType.input,
            value: config.rlimitNofile,
            key: 'rlimit-nofile',
            readOnly: true,
            tooltip:
                "设置打开的文件描述符的软限制 (soft limit). 此选项仅当满足如下条件时开放: a. 系统支持它 (posix). b. 限制没有超过硬限制 (hard limit). c. 指定的限制比当前的软限制高. 这相当于设置ulimit, 除了其不能降低限制. 此选项仅当系统支持 rlimit API 时有效."),
        //终端输出使用颜色(enable-color)
        FormItem<bool>(
            label: '终端输出使用颜色',
            type: FormItemType.switch_,
            value: config.enableColor,
            key: 'enable-color',
            readOnly: true),
        //启用 MMap(enable-mmap) tooltip:'内存中存放映射文件. 当文件空间没有预先分配至, 此选项无效. 参见 --file-allocation.'
        FormItem<bool>(
            label: '启用 MMap',
            type: FormItemType.switch_,
            value: config.enableMmap,
            key: 'enable-mmap',
            tooltip: "内存中存放映射文件. 当文件空间没有预先分配至, 此选项无效. 参见 --file-allocation."),
        //事件轮询方法(event-poll) tooltip:'设置事件轮询的方法. 可选的值包括 epoll, kqueue, port, poll 和 select. 对于 epoll, kqueue, port 和 poll, 只有系统支持时才可用. 最新的 Linux 支持 epoll. 各种 *BSD 系统包括 Mac OS X 支持 kqueue. Open Solaris 支持 port. 默认值根据您使用的操作系统不同而不同.'
        FormItem<String>(
          label: '事件轮询方法',
          type: FormItemType.select,
          value: config.eventPoll,
          key: 'event-poll',
          options: [
            FormItemOption(label: "EPOLL", value: "epoll"),
            FormItemOption(label: "KQUEUE", value: "kqueue"),
            FormItemOption(label: "PORT", value: "port"),
            FormItemOption(label: "POLL", value: "poll"),
            FormItemOption(label: "SELECT", value: "select"),
          ],
          readOnly: true,
          tooltip:
              "设置事件轮询的方法. 可选的值包括 epoll, kqueue, port, poll 和 select. 对于 epoll, kqueue, port 和 poll, 只有系统支持时才可用. 最新的 Linux 支持 epoll. 各种 *BSD 系统包括 Mac OS X 支持 kqueue. Open Solaris 支持port. 默认值根据您使用的操作系统不同而不同.",
        ),
        //文件分配方法(file-allocation) tooltip:'指定文件分配方法. "无" 不会预先分配文件空间. "prealloc"会在下载开始前预先分配空间. 这将会根据文件的大小需要一定的时间. 如果您使用的是较新的文件系统, 例如 ext4 (带扩展支持), btrfs, xfs 或 NTFS (仅 MinGW 构建), "falloc" 是最好的选择. 其几乎可以瞬间分配大(数 GiB)文件. 不要在旧的文件系统, 例如 ext3 和 FAT32 上使用 falloc, 因为与 prealloc 花费的时间相同, 并且其会阻塞 aria2 直到分配完成. 当您的系统不支持 posix_fallocate(3) 函数时, falloc 可能无法使用. "trunc" 使用 ftruncate(2) 系统调用或平台特定的实现将文件截取到特定的长度. 在多文件的 BitTorrent 下载中, 若某文件与其相邻的文件共享相同的分片时, 则相邻的文件也会被分配.'
        FormItem<String>(
            label: '文件分配方法',
            type: FormItemType.select,
            value: config.fileAllocation,
            key: 'file-allocation',
            options: [
              FormItemOption(label: "无", value: "none"),
              FormItemOption(label: "预分配", value: "prealloc"),
              FormItemOption(label: "立即分配", value: "falloc"),
              FormItemOption(label: "TRUNC", value: "trunc"),
            ],
            tooltip:
                "指定文件分配方法. \"无\" 不会预先分配文件空间. \"prealloc\"会在下载开始前预先分配空间. 这将会根据文件的大小需要一定的时间. 如果您使用的是较新的文件系统, 例如 ext4 (带扩展支持), btrfs, xfs 或 NTFS (仅 MinGW 构建), \"falloc\" 是最好的选择. 其几乎可以瞬间分配大(数 GiB)文件. 不要在旧的文件系统, 例如 ext3 和 FAT32 上使用 falloc, 因为与 prealloc 花费的时间相同, 并且其会阻塞 aria2 直到分配完成. 当您的系统不支持 posix_fallocate(3) 函数时, falloc 可能无法使用. \"trunc\" 使用 ftruncate(2) 系统调用或平台特定的实现将文件截取到特定的长度. 在多文件的 BitTorrent 下载中, 若某文件与其相邻的文件共享相同的分片时, 则相邻的文件也会被分配.'"),
        //强制保存(force-save) tooltip:'即使任务完成或删除时使用 --save-session 选项时也保存该任务. 此选项在这种情况下还会保存控制文件. 此选项可以保存被认为已经完成但正在做种的 BT 任务.'
        FormItem<bool>(
            label: '强制保存',
            type: FormItemType.switch_,
            value: config.forceSave,
            key: 'force-save',
            tooltip:
                "即使任务完成或删除时使用 --save-session 选项时也保存该任务. 此选项在这种情况下还会保存控制文件. 此选项可以保存被认为已经完成但正在做种的 BT 任务."),
        //保存未找到的文件(save-not-found) tooltip:'当使用 --save-session 选项时, 即使当任务中的文件不存在时也保存该下载任务. 此选项同时会将这种情况保存到控制文件中.'
        FormItem<bool>(
            label: '保存未找到的文件',
            type: FormItemType.switch_,
            value: config.saveNotFound,
            key: 'save-not-found',
            tooltip:
                "当使用 --save-session 选项时, 即使当任务中的文件不存在时也保存该下载任务. 此选项同时会将这种情况保存到控制文件中."),
        //仅哈希检查(hash-check-only) tooltip:'如果设置为"是", 哈希检查完使用 --check-integrity 选项, 根据是否下载完成决定是否终止下载.'
        FormItem<bool>(
            label: '仅哈希检查',
            type: FormItemType.switch_,
            value: config.hashCheckOnly,
            key: 'hash-check-only',
            tooltip:
                "如果设置为\"是\", 哈希检查完使用 --check-integrity 选项, 根据是否下载完成决定是否终止下载."),
        //控制台可读输出(human-readable) tooltip:'在控制台输出可读格式的大小和速度 (例如, 1.2Ki, 3.4Mi).'
        FormItem<bool>(
            label: '控制台可读输出',
            type: FormItemType.switch_,
            value: config.humanReadable,
            key: 'human-readable',
            readOnly: true,
            tooltip: "在控制台输出可读格式的大小和速度 (例如, 1.2Ki, 3.4Mi)."),
        //保留未完成的任务(keep-unfinished-download-result) tooltip:'保留所有未完成的下载结果, 即使超过了 --max-download-result 选项设置的数量. 这将有助于在会话文件中保存所有的未完成的下载 (参考 --save-session 选项). 需要注意的是, 未完成任务的数量没有上限. 如果不希望这样, 请关闭此选项.'
        FormItem<bool>(
            label: '保留未完成的任务',
            type: FormItemType.switch_,
            value: config.keepUnfinishedDownloadResult,
            key: 'keep-unfinished-download-result',
            tooltip:
                "保留所有未完成的下载结果, 即使超过了 --max-download-result 选项设置的数量. 这将有助于在会话文件中保存所有的未完成的下载 (参考 --save-session 选项). 需要注意的是, 未完成任务的数量没有上限. 如果不希望这样, 请关闭此选项."),
        //最多下载结果(max-download-result) tooltip:'设置内存中存储最多的下载结果数量. 下载结果包括已完成/错误/已删除的下载. 下载结果存储在一个先进先出的队列中, 因此其可以存储最多指定的下载结果的数量. 当队列已满且有新的下载结果创建时, 最老的下载结果将从队列的最前部移除, 新的将放在最后. 此选项设置较大的值后如果经过几千次的下载将导致较高的内存消耗. 设置为 0 表示不存储下载结果. 注意, 未完成的下载将始终保存在内存中, 不考虑该选项的设置. 参考 --keep-unfinished-download-result 选项.'
        FormItem<int>(
            label: '最多下载结果',
            type: FormItemType.input,
            value: config.maxDownloadResult,
            key: 'max-download-result',
            tooltip:
                "设置内存中存储最多的下载结果数量. 下载结果包括已完成/错误/已删除的下载. 下载结果存储在一个先进先出的队列中, 因此其可以存储最多指定的下载结果的数量. 当队列已满且有新的下载结果创建时, 最老的下载结果将从队列的最前部移除, 新的将放在最后. 此选项设置较大的值后如果经过几千次的下载将导致较高的内存消耗. 设置为 0 表示不存储下载结果. 注意, 未完成的下载将始终保存在内存中, 不考虑该选项的设置. 参考 --keep-unfinished-download-result 选项."),
        //MMap 最大限制(max-mmap-limit) tooltip:'设置启用 MMap (参见 --enable-mmap 选项) 最大的文件大小. 文件大小由一个下载任务中所有文件大小的和决定. 例如, 如果一个下载包含 5 个文件, 那么文件大小就是这些文件的总大小. 如果文件大小超过此选项设置的大小时, MMap 将会禁用.'
        FormItem<int>(
            label: 'MMap 最大限制',
            type: FormItemType.input,
            value: config.maxMmapLimit,
            key: 'max-mmap-limit',
            tooltip:
                "设置启用 MMap (参见 --enable-mmap 选项) 最大的文件大小. 文件大小由一个下载任务中所有文件大小的和决定. 例如, 如果一个下载包含 5 个文件, 那么文件大小就是这些文件的总大小. 如果文件大小超过此选项设置的大小时, MMap 将会禁用."),
        //最大断点续传尝试次数(max-resume-failure-tries) tooltip:'当 --always-resume 选项设置为"否"时, 如果 aria2 检测到有 N 个 URI 不支持断点续传时, 将从头开始下载文件. 如果 N 设置为 0, 当所有 URI 都不支持断点续传时才会从头下载文件. 参见 --always-resume 选项.'
        FormItem<int>(
            label: '最大断点续传尝试次数',
            type: FormItemType.input,
            value: config.maxResumeFailureTries,
            key: 'max-resume-failure-tries',
            tooltip:
                "当 --always-resume 选项设置为\"否\"时, 如果 aria2 检测到有 N 个 URI 不支持断点续传时, 将从头开始下载文件. 如果 N 设置为 0, 当所有 URI 都不支持断点续传时才会从头下载文件. 参见 --always-resume 选项."),
        //最低 TLS 版本(min-tls-version) tooltip:'指定启用的最低 SSL/TLS 版本.'
        FormItem<String>(
            label: '最低 TLS 版本',
            type: FormItemType.select,
            value: config.minTlsVersion,
            key: 'min-tls-version',
            readOnly: true,
            options: [
              FormItemOption(label: "TLSv1.1", value: "TLSv1.1"),
              FormItemOption(label: "TLSv1.2", value: "TLSv1.2"),
              FormItemOption(label: "TLSv1.3", value: "TLSv1.3"),
            ],
            tooltip: "指定启用的最低 SSL/TLS 版本."),
        //日志级别(log-level)
        FormItem<String>(
          label: '日志级别',
          type: FormItemType.select,
          value: config.logLevel,
          options: [
            FormItemOption(label: "DEBUG", value: "debug"),
            FormItemOption(label: "INFO", value: "info"),
            FormItemOption(label: "NOTICE", value: "notice"),
            FormItemOption(label: "WARN", value: "warn"),
            FormItemOption(label: "ERROR", value: "error"),
          ],
          key: 'log-level',
        ),
        //优化并发下载(optimize-concurrent-downloads) tooltip:'根据可用带宽优化并发下载的数量. aria2 使用之前统计的下载速度通过规则 N = A + B Log10 (速度单位为 Mbps) 得到并发下载的数量. 其中系数 A 和 B 可以在参数中以冒号分隔自定义. 默认值 (A=5, B=25) 可以在 1Mbps 网络上使用通常 5 个并发下载, 在 100Mbps 网络上为 50 个. 并发下载的数量保持在 --max-concurrent-downloads 参数定义的最大之下.'
        FormItem<bool>(
            label: '优化并发下载',
            type: FormItemType.switch_,
            value: config.optimizeConcurrentDownloads,
            key: 'optimize-concurrent-downloads',
            tooltip:
                "根据可用带宽优化并发下载的数量. aria2 使用之前统计的下载速度通过规则 N = A + B Log10 (速度单位为 Mbps) 得到并发下载的数量. 其中系数 A 和 B 可以在参数中以冒号分隔自定义. 默认值 (A=5,B=25) 可以在 1Mbps 网络上使用通常 5 个并发下载, 在 100Mbps 网络上为 50 个. 并发下载的数量保持在 --max-concurrent-downloads 参数定义的最大之下."),
        //文件分片大小(piece-length) tooltip:'设置 HTTP/FTP 下载的分配大小. aria2 根据这个边界分割文件. 所有的分割都是这个长度的倍数. 此选项不适用于 BitTorrent 下载. 如果 Metalink 文件中包含分片哈希的结果此选项也不适用.'
        FormItem<int>(
            label: '文件分片大小',
            type: FormItemType.input,
            value: config.pieceLength,
            key: 'piece-length',
            trailingBuilder: (context) => buildUnitTrailing(context, "字节"),
            tooltip:
                "设置 HTTP/FTP 下载的分配大小. aria2 根据这个边界分割文件. 所有的分割都是这个长度的倍数. 此选项不适用于 BitTorrent 下载. 如果 Metalink 文件中包含分片哈希的结果此选项也不适用."),
        //显示控制台输出(show-console-readout)
        FormItem<bool>(
            label: '显示控制台输出',
            type: FormItemType.switch_,
            value: config.showConsoleReadout,
            key: 'show-console-readout',
            readOnly: true,
            tooltip: "显示控制台输出"),
        //下载摘要输出间隔(summary-interval) tooltip:'设置下载进度摘要的输出间隔(秒). 设置为 0 禁止输出.'
        FormItem<int>(
            label: '下载摘要输出间隔',
            type: FormItemType.input,
            value: config.summaryInterval,
            key: 'summary-interval',
            trailingBuilder: (context) => buildUnitTrailing(context, "秒"),
            readOnly: true,
            tooltip: "设置下载进度摘要的输出间隔(秒). 设置为 0 禁止输出."),
        //全局最大下载速度(max-overall-download-limit) tooltip:'设置全局最大下载速度 (字节/秒). 0 表示不限制. 您可以增加数值的单位 K 或 M (1K = 1024, 1M = 1024K).'
        FormItem<int>(
            label: '全局最大下载速度',
            type: FormItemType.input,
            value: config.maxOverallDownloadLimit,
            key: 'max-overall-download-limit',
            trailingBuilder: (context) => buildUnitTrailing(context, "字节"),
            tooltip:
                "设置全局最大下载速度 (字节/秒). 0 表示不限制. 您可以增加数值的单位 K 或 M (1K = 1024, 1M = 1024K)."),
        //最大下载速度(max-download-limit) tooltip:'设置每个任务的最大下载速度 (字节/秒). 0 表示不限制. 您可以增加数值的单位 K 或 M (1K = 1024, 1M = 1024K).'
        FormItem<int>(
            label: '最大下载速度',
            type: FormItemType.input,
            value: config.maxDownloadLimit,
            key: 'max-download-limit',
            trailingBuilder: (context) => buildUnitTrailing(context, "字节"),
            tooltip:
                "设置每个任务的最大下载速度 (字节/秒). 0 表示不限制. 您可以增加数值的单位 K 或 M (1K = 1024, 1M = 1024K)."),
        //禁用配置文件(no-conf)
        FormItem<bool>(
            label: '禁用配置文件',
            type: FormItemType.switch_,
            value: config.noConf,
            key: 'no-conf',
            readOnly: true,
            tooltip: "禁用配置文件"),
        //文件分配限制(no-file-allocation-limit) tooltip:'不对比此参数设置大小小的分配文件. 您可以增加数值的单位 K 或 M (1K = 1024, 1M = 1024K).'
        FormItem<int>(
            label: '文件分配限制',
            type: FormItemType.input,
            value: config.noFileAllocationLimit,
            key: 'no-file-allocation-limit',
            trailingBuilder: (context) => buildUnitTrailing(context, "字节"),
            tooltip:
                "不对比此参数设置大小小的分配文件. 您可以增加数值的单位 K 或 M (1K = 1024, 1M = 1024K)."),
        //启用参数化 URI 支持(parameterized-uri) tooltip:'启用参数化 URI 支持. 您可以指定部分的集合: http://{sv1,sv2,sv3}/foo.iso. 同时您也可以使用步进计数器指定数字化的序列: http://host/image[000-100:2].img. 步进计数器可以省略. 如果所有 URI 地址不指向同样的文件, 例如上述第二个示例, 需要使用 -Z 选项.'
        FormItem<bool>(
            label: '启用参数化 URI 支持',
            type: FormItemType.switch_,
            value: config.parameterizedUri,
            key: 'parameterized-uri',
            tooltip:
                "启用参数化 URI 支持. 您可以指定部分的集合: http://{sv1,sv2,sv3}/foo.iso. 同时您也可以使用步进计数器指定数字化的序列: http://host/image[000-100:2].img. 步进计数器可以省略. 如果所有 URI 地址不指向同样的文件, 例如上述第二个示例, 需要使用 -Z 选项."),
        //禁用控制台输出(quiet)
        FormItem<bool>(
            label: '禁用控制台输出',
            type: FormItemType.switch_,
            value: config.quiet,
            key: 'quiet',
            readOnly: true,
            tooltip: "禁用控制台输出"),
        //实时数据块验证(realtime-chunk-checksum) tooltip:'如果提供了数据块的校验和, 将在下载过程中通过校验和验证数据块.'
        FormItem<bool>(
            label: '实时数据块验证',
            type: FormItemType.switch_,
            value: config.realtimeChunkChecksum,
            key: 'realtime-chunk-checksum',
            tooltip: "如果提供了数据块的校验和, 将在下载过程中通过校验和验证数据块."),
        //删除控制文件(remove-control-file) tooltip:'在下载前删除控制文件. 使用 --allow-overwrite=true 选项时, 总是从头开始下载文件. 此选项将有助于使用不支持断点续传代理服务器的用户.'
        FormItem<bool>(
            label: '删除控制文件',
            type: FormItemType.switch_,
            value: config.removeControlFile,
            key: 'remove-control-file',
            tooltip:
                "在下载前删除控制文件. 使用 --allow-overwrite=true 选项时, 总是从头开始下载文件. 此选项将有助于使用不支持断点续传代理服务器的用户."),
        //状态保存文件(save-session) tooltip:'当退出时保存错误及未完成的任务到指定的文件中. 您可以在重启 aria2 时使用 --input-file 选项重新加载. 如果您希望输出的内容使用 GZip 压缩, 您可以在文件名后增加 .gz 扩展名. 请注意, 通过 aria2.addTorrent() 和 aria2.addMetalink() RPC 方法添加的下载, 其元数据没有保存到文件的将不会保存. 通过 aria2.remove() 和 aria2.forceRemove() 删除的下载将不会保存.'
        FormItem<String>(
            label: '状态保存文件',
            type: FormItemType.input,
            value: config.saveSession,
            key: 'save-session',
            tooltip:
                "当退出时保存错误及未完成的任务到指定的文件中. 您可以在重启 aria2 时使用 --input-file 选项重新加载. 如果您希望输出的内容使用 GZip 压缩, 您可以在文件名后增加 .gz 扩展名. 请注意, 通过 aria2.addTorrent() 和 aria2.addMetalink() RPC 方法添加的下载, 其元数据没有保存到文件的将不会保存. 通过 aria2.remove() 和 aria2.forceRemove() 删除的下载将不会保存."),
        //保存状态间隔(save-session-interval) tooltip:'每隔此选项设置的时间(秒)后会保存错误或未完成的任务到 --save-session 选项指定的文件中. 如果设置为 0, 仅当 aria2 退出时才会保存.'
        FormItem<int>(
            label: '保存状态间隔',
            type: FormItemType.input,
            value: config.saveSessionInterval,
            key: 'save-session-interval',
            trailingBuilder: (context) => buildUnitTrailing(context, "秒"),
            readOnly: true,
            tooltip:
                "每隔此选项设置的时间(秒)后会保存错误或未完成的任务到 --save-session 选项指定的文件中. 如果设置为 0, 仅当 aria2 退出时才会保存."),
        //Socket 接收缓冲区大小(socket-recv-buffer-size) tooltip:'设置 Socket 接收缓冲区最大的字节数. 指定为 0 时将禁用此选项. 当使用 SO_RCVBUF 选项调用 setsockopt() 时此选项的值将设置到 Socket 的文件描述符中.'
        FormItem<int>(
            label: 'Socket 接收缓冲区大小',
            type: FormItemType.input,
            value: config.socketRecvBufferSize,
            key: 'socket-recv-buffer-size',
            trailingBuilder: (context) => buildUnitTrailing(context, "字节"),
            readOnly: true,
            tooltip:
                "设置 Socket 接收缓冲区最大的字节数. 指定为 0 时将禁用此选项. 当使用 SO_RCVBUF 选项调用 setsockopt() 时此选项的值将设置到 Socket 的文件描述符中."),
        //自动关闭时间(stop) tooltip:'在此选项设置的时间(秒)后关闭应用. 如果设置为 0, 此功能将禁用.'
        FormItem<int>(
            label: '自动关闭时间',
            type: FormItemType.input,
            value: config.stop,
            key: 'stop',
            trailingBuilder: (context) => buildUnitTrailing(context, "秒"),
            readOnly: true,
            tooltip: "在此选项设置的时间(秒)后关闭应用. 如果设置为 0, 此功能将禁用."),
        //缩短控制台输出内容(truncate-console-readout) tooltip:'缩短控制台输出的内容在一行中.'
        FormItem<bool>(
            label: '缩短控制台输出内容',
            type: FormItemType.switch_,
            value: config.truncateConsoleReadout,
            key: 'truncate-console-readout',
            readOnly: true,
            tooltip: "缩短控制台输出的内容在一行中."),
      ],
      itemBuilder: (context, item) {
        return OptionItem(
          formItem: item,
        );
      });
}
