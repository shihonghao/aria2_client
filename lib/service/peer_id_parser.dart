import 'dart:convert';

typedef V = String Function(String s);

String decodePercentEncodedString(String s) {
  var ret = '';

  for (var i = 0; i < s.length; i++) {
    var ch = s[i];

    if (ch == '%' && i < s.length - 2) {
      var code = s.substring(i + 1, i + 3);
      ret += String.fromCharCode(int.parse(code, radix: 16));
      i += 2;
    } else {
      ret += ch;
    }
  }

  return ret;
}

bool isAzStyle(String peerId) {
  if (peerId[0] != '-') return false;
  if (peerId[7] == '-') return true;

  // Hack for FlashGet - it doesn't use the trailing dash.
  // Also, LH-ABC has strayed into "forgetting about the delimiter" territory.
  // In fact, the code to generate a peer ID for LH-ABC is based on BitTornado's,
  // yet tries to give an Az style peer ID... oh dear.
  // BT Next Evolution seems to be in the same boat as well.
  // KTorrent 3 appears to use a dash rather than a final character.
  if (['FG', 'LH', 'NE', 'KT', 'SP'].contains(peerId.substring(1, 3))) {
    return true;
  }

  return false;
}

bool isShadowStyle(String peerId) {
  if (peerId[5] != '-') return false;
  if (!isLetter(peerId[0])) return false;
  if (!(isDigit(peerId[1]) || peerId[1] == '-')) return false;

  // Find where the version number string ends.
  int lastVersionNumberIndex = 4;
  for (; lastVersionNumberIndex > 0; lastVersionNumberIndex--) {
    if (peerId[lastVersionNumberIndex] != '-') break;
  }

  // For each digit in the version string, check if it is a valid version identifier.
  for (int i = 1; i <= lastVersionNumberIndex; i++) {
    String c = peerId[i];
    if (c == '-') return false;
    if (isAlphaNumeric(c) == null) return false;
  }

  return true;
}

bool isMainlineStyle(String peerId) {
  // One of the following styles will be used:
  //   Mx-y-z--
  //   Mx-yy-z-
  return peerId[2] == '-' &&
      peerId[7] == '-' &&
      (peerId[4] == '-' || peerId[5] == '-');
}

bool isPossibleSpoofClient(String peerId) {
  return peerId.endsWith('UDP0') || peerId.endsWith('HTTPBT');
}

String? getAzStyleVersionNumber(String peerId, [V? version]) {
  if (version != null) {
    return version(peerId);
  }
  return null;
}

String? getShadowStyleVersionNumber(String peerId) {
  // TODO
  return null;
}

Map<String, dynamic>? decodeBitSpiritClient(String peerId, List<int> buffer) {
  if (peerId.substring(2, 4) != 'BS') return null;
  String version = '${buffer[1]}';
  if (version == '0') version = '1';

  return {'client': 'BitSpirit', 'version': version};
}

Map<String, dynamic>? decodeBitCometClient(String peerId, List<int> buffer) {
  String modName = '';
  if (peerId.startsWith('exbc')) {
    modName = '';
  } else if (peerId.startsWith('FUTB')) {
    modName = '(Solidox Mod)';
  } else if (peerId.startsWith('xUTB')) {
    modName = '(Mod 2)';
  } else {
    return null;
  }

  bool isBitlord = (peerId.substring(6, 10) == 'LORD');

  // Older versions of BitLord are of the form x.yy, whereas new versions (1 and onwards),
  // are of the form x.y. BitComet is of the form x.yy
  String clientName = (isBitlord) ? 'BitLord' : 'BitComet';
  String majVersion = decodeNumericValueOfByte(buffer[4]);
  int minVersionLength = (isBitlord && majVersion != '0' ? 1 : 2);

  return {
    'client': clientName + (modName.isEmpty ? '' : ' $modName'),
    'version':
        '$majVersion.${decodeNumericValueOfByte(buffer[5], minVersionLength)}'
  };
}

Map<String, dynamic>? identifyAwkwardClient(String peerId, List<int> buffer) {
  int firstNonZeroIndex = 20;
  for (int i = 0; i < 20; i++) {
    if (buffer[i] > 0) {
      firstNonZeroIndex = i;
      break;
    }
  }

  // Shareaza check
  if (firstNonZeroIndex == 0) {
    bool isShareaza = true;
    for (int i = 0; i < 16; i++) {
      if (buffer[i] == 0) {
        isShareaza = false;
        break;
      }
    }

    if (isShareaza) {
      for (int i = 16; i < 20; i++) {
        if (buffer[i] != (buffer[i % 16] ^ buffer[15 - (i % 16)])) {
          isShareaza = false;
          break;
        }
      }

      if (isShareaza) return {'client': 'Shareaza'};
    }
  }

  if (firstNonZeroIndex == 9 &&
      buffer[9] == 3 &&
      buffer[10] == 3 &&
      buffer[11] == 3) {
    return {'client': 'I2PSnark'};
  }

  if (firstNonZeroIndex == 12 && buffer[12] == 97 && buffer[13] == 97) {
    return {'client': 'Experimental', 'version': '3.2.1b2'};
  }

  if (firstNonZeroIndex == 12 && buffer[12] == 0 && buffer[13] == 0) {
    return {'client': 'Experimental', 'version': '3.1'};
  }

  if (firstNonZeroIndex == 12) {
    return {'client': 'Mainline'};
  }

  return null;
}

String decodeNumericValueOfByte(int b, [int minDigits = 0]) {
  String result = '${b & 0xff}';
  while (result.length < minDigits) {
    result = '0$result';
  }
  return result;
}

// Private helper functions for the public utility functions
bool isDigit(String s) {
  int code = s.codeUnitAt(0);
  return code >= '0'.codeUnitAt(0) && code <= '9'.codeUnitAt(0);
}

bool isLetter(String s) {
  int code = s.toLowerCase().codeUnitAt(0);
  return code >= 'a'.codeUnitAt(0) && code <= 'z'.codeUnitAt(0);
}

bool? isAlphaNumeric(String s) {
  return isDigit(s) || isLetter(s) || s == '.';
}

class PeerIdParser {
  PeerIdParser._privateConstructor();

  static final PeerIdParser _parser = PeerIdParser._privateConstructor();

  factory PeerIdParser() {
    return _parser;
  }

  static PeerIdParser get instance {
    _parser.init();
    return _parser;
  }

  bool isInitialized = false;

  init() {
    if (isInitialized) {
      return;
    }
    addAzStyle('A~', 'Ares', VER_AZ_THREE_DIGITS);
    addAzStyle('AG', 'Ares', VER_AZ_THREE_DIGITS);
    addAzStyle('AN', 'Ares', VER_AZ_FOUR_DIGITS);
    addAzStyle('AR', 'Ares'); // Ares is more likely than ArcticTorrent
    addAzStyle('AV', 'Avicora');
    addAzStyle('AX', 'BitPump', VER_AZ_TWO_MAJ_TWO_MIN);
    addAzStyle('AT', 'Artemis');
    addAzStyle('AZ', 'Vuze', VER_AZ_FOUR_DIGITS);
    addAzStyle('BB', 'BitBuddy', '1.234');
    addAzStyle('BC', 'BitComet', VER_AZ_SKIP_FIRST_ONE_MAJ_TWO_MIN);
    addAzStyle('BE', 'BitTorrent SDK');
    addAzStyle('BF', 'BitFlu', VER_NONE);
    addAzStyle('BG', 'BTG', VER_AZ_FOUR_DIGITS);
    addAzStyle('bk', 'BitKitten (libtorrent)');
    addAzStyle('BR', 'BitRocket', '1.2(34)');
    addAzStyle('BS', 'BTSlave');
    addAzStyle('BT', 'BitTorrent', VER_AZ_THREE_DIGITS_PLUS_MNEMONIC);
    addAzStyle('BW', 'BitWombat');
    addAzStyle('BX', 'BittorrentX');
    addAzStyle('CB', 'Shareaza Plus');
    addAzStyle('CD', 'Enhanced CTorrent', VER_AZ_TWO_MAJ_TWO_MIN);
    addAzStyle('CT', 'CTorrent', '1.2.34');
    addAzStyle('DP', 'Propogate Data Client');
    addAzStyle('DE', 'Deluge', VER_AZ_DELUGE);
    addAzStyle('EB', 'EBit');
    addAzStyle('ES', 'Electric Sheep', VER_AZ_THREE_DIGITS);
    addAzStyle('FC', 'FileCroc');
    addAzStyle('FG', 'FlashGet', VER_AZ_SKIP_FIRST_ONE_MAJ_TWO_MIN);
    addAzStyle('FX', 'Freebox BitTorrent');
    addAzStyle('FT', 'FoxTorrent/RedSwoosh');
    addAzStyle('GR', 'GetRight', '1.2');
    addAzStyle('GS', 'GSTorrent'); // TODO: Format is v"abcd"
    addAzStyle('HL', 'Halite', VER_AZ_THREE_DIGITS);
    addAzStyle('HN', 'Hydranode');
    addAzStyle('KG', 'KGet');
    addAzStyle('KT', 'KTorrent', VER_AZ_KTORRENT_STYLE);
    addAzStyle('LC', 'LeechCraft');
    addAzStyle('LH', 'LH-ABC');
    addAzStyle('LK', 'linkage', VER_AZ_THREE_DIGITS);
    addAzStyle('LP', 'Lphant', VER_AZ_TWO_MAJ_TWO_MIN);
    addAzStyle(
        'LT', 'libtorrent (Rasterbar)', VER_AZ_THREE_ALPHANUMERIC_DIGITS);
    addAzStyle('lt', 'libTorrent (Rakshasa)', VER_AZ_THREE_ALPHANUMERIC_DIGITS);
    addAzStyle('LW', 'LimeWire',
        VER_NONE); // The "0001" bytes found after the LW commonly refers to the version of the BT protocol implemented. Documented here: http://www.limewire.org/wiki/index.php?title=BitTorrentRevision
    addAzStyle('MO', 'MonoTorrent');
    addAzStyle('MP', 'MooPolice', VER_AZ_THREE_DIGITS);
    addAzStyle('MR', 'Miro');
    addAzStyle('MT', 'MoonlightTorrent');
    addAzStyle('NE', 'BT Next Evolution', VER_AZ_THREE_DIGITS);
    addAzStyle('NX', 'Net Transport');
    addAzStyle('OS', 'OneSwarm', VER_AZ_FOUR_DIGITS);
    addAzStyle('OT', 'OmegaTorrent');
    addAzStyle('PC', 'CacheLogic', '12.3-4');
    addAzStyle('PT', 'Popcorn Time');
    addAzStyle('PD', 'Pando');
    addAzStyle('PE', 'PeerProject');
    addAzStyle('pX', 'pHoeniX');
    addAzStyle('qB', 'qBittorrent', VER_AZ_DELUGE);
    addAzStyle('QD', 'qqdownload');
    addAzStyle('RM', 'RUM Torrent');
    addAzStyle('RT', 'Retriever');
    addAzStyle('RZ', 'RezTorrent');
    addAzStyle('S~', 'Shareaza alpha/beta');
    addAzStyle('SB', 'SwiftBit');
    addAzStyle('SD',
        '\u8FC5\u96F7\u5728\u7EBF (Xunlei)'); // Apparently, the English name of the client is "Thunderbolt".
    addAzStyle('SG', 'GS Torrent', VER_AZ_FOUR_DIGITS);
    addAzStyle('SN', 'ShareNET');
    addAzStyle('SP', 'BitSpirit', VER_AZ_THREE_DIGITS); // >= 3.6
    addAzStyle('SS', 'SwarmScope');
    addAzStyle('ST', 'SymTorrent', '2.34');
    addAzStyle('st', 'SharkTorrent');
    addAzStyle('SZ', 'Shareaza');
    addAzStyle('TG', 'Torrent GO');
    addAzStyle('TN', 'Torrent.NET');
    addAzStyle('TR', 'Transmission', VER_AZ_TRANSMISSION_STYLE);
    addAzStyle('TS', 'TorrentStorm');
    addAzStyle('TT', 'TuoTu', VER_AZ_THREE_DIGITS);
    addAzStyle('UL', 'uLeecher!');
    addAzStyle(
        'UE', '\u00B5Torrent Embedded', VER_AZ_THREE_DIGITS_PLUS_MNEMONIC);
    addAzStyle('UT', '\u00B5Torrent', VER_AZ_THREE_DIGITS_PLUS_MNEMONIC);
    addAzStyle('UM', '\u00B5Torrent Mac', VER_AZ_THREE_DIGITS_PLUS_MNEMONIC);
    addAzStyle('UW', '\u00B5Torrent Web', VER_AZ_THREE_DIGITS_PLUS_MNEMONIC);
    addAzStyle('WD', 'WebTorrent Desktop',
        VER_AZ_WEBTORRENT_STYLE); // Go Webtorrent!! :)
    addAzStyle('WT', 'Bitlet');
    addAzStyle(
        'WW', 'WebTorrent', VER_AZ_WEBTORRENT_STYLE); // Go Webtorrent!! :)
    addAzStyle('WY', 'FireTorrent'); // formerly Wyzo.
    addAzStyle('VG', '\u54c7\u560E (Vagaa)', VER_AZ_FOUR_DIGITS);
    addAzStyle('XL',
        '\u8FC5\u96F7\u5728\u7EBF (Xunlei)'); // Apparently, the English name of the client is "Thunderbolt".
    addAzStyle('XT', 'XanTorrent');
    addAzStyle('XF', 'Xfplay', VER_AZ_TRANSMISSION_STYLE);
    addAzStyle('XX', 'XTorrent', '1.2.34');
    addAzStyle('XC', 'XTorrent', '1.2.34');
    addAzStyle('ZT', 'ZipTorrent');
    addAzStyle('7T', 'aTorrent');
    addAzStyle('ZO', 'Zona', VER_AZ_FOUR_DIGITS);
    addAzStyle('#@', 'Invalid PeerID');

    addShadowStyle('A', 'ABC');
    addShadowStyle('O', 'Osprey Permaseed');
    addShadowStyle('Q', 'BTQueue');
    addShadowStyle('R', 'Tribler');
    addShadowStyle('S', 'Shad0w');
    addShadowStyle('T', 'BitTornado');
    addShadowStyle('U', 'UPnP NAT');

    addMainlineStyle('M', 'Mainline');
    addMainlineStyle('Q', 'Queen Bee');

    // Simple clients with no version number.
    addSimpleClient('\u00B5Torrent', '1.7.0 RC',
        '-UT170-'); // http://forum.utorrent.com/viewtopic.php?pid=260927#p260927
    addSimpleClient('Azureus', '1', 'Azureus');
    addSimpleClient('Azureus', '2.0.3.2', 'Azureus', 5);
    addSimpleClient('Aria', '2', '-aria2-');
    addSimpleClient('BitTorrent Plus!', 'II', 'PRC.P---');
    addSimpleClient('BitTorrent Plus!', 'P87.P---');
    addSimpleClient('BitTorrent Plus!', 'S587Plus');
    addSimpleClient('BitTyrant (Azureus Mod)', 'AZ2500BT');
    addSimpleClient('Blizzard Downloader', 'BLZ');
    addSimpleClient('BTGetit', 'BG', 10);
    addSimpleClient('BTugaXP', 'btuga');
    addSimpleClient('BTugaXP', 'BTuga', 5);
    addSimpleClient('BTugaXP', 'oernu');
    addSimpleClient('Deadman Walking', 'BTDWV-');
    addSimpleClient('Deadman', 'Deadman Walking-');
    addSimpleClient('External Webseed', 'Ext');
    addSimpleClient('G3 Torrent', '-G3');
    addSimpleClient('GreedBT', '2.7.1', '271-');
    addSimpleClient('Hurricane Electric', 'arclight');
    addSimpleClient('HTTP Seed', '-WS');
    addSimpleClient('JVtorrent', '10-------');
    addSimpleClient('Limewire', 'LIME');
    addSimpleClient('Martini Man', 'martini');
    addSimpleClient('Pando', 'Pando');
    addSimpleClient('PeerApp', 'PEERAPP');
    addSimpleClient('SimpleBT', 'btfans', 4);
    addSimpleClient('Swarmy', 'a00---0');
    addSimpleClient('Swarmy', 'a02---0');
    addSimpleClient('Teeweety', 'T00---0');
    addSimpleClient('TorrentTopia', '346-');
    addSimpleClient('XanTorrent', 'DansClient');
    addSimpleClient('MediaGet', '-MG1');
    addSimpleClient('MediaGet', '2.1', '-MG21');

    /**
     * This is interesting - it uses Mainline style, except uses two characters instead of one.
     * And then - the particular numbering style it uses would actually break the way we decode
     * version numbers (our code is too hardcoded to "-x-y-z--" style version numbers).
     *
     * This should really be declared as a Mainline style peer ID, but I would have to
     * make my code more generic. Not a bad thing - just something I'm not doing right
     * now.
     */
    addSimpleClient('Amazon AWS S3', 'S3-');

    // Simple clients with custom version schemes
    // TODO: support custom version schemes
    addSimpleClient('BitTorrent DNA', 'DNA');
    addSimpleClient('Opera', 'OP'); // Pre build 10000 versions
    addSimpleClient('Opera', 'O'); // Post build 10000 versions
    addSimpleClient('Burst!', 'Mbrst');
    addSimpleClient('TurboBT', 'turbobt');
    addSimpleClient('BT Protocol Daemon', 'btpd');
    addSimpleClient('Plus!', 'Plus');
    addSimpleClient('XBT', 'XBT');
    addSimpleClient('BitsOnWheels', '-BOW');
    addSimpleClient('eXeem', 'eX');
    addSimpleClient('MLdonkey', '-ML');
    addSimpleClient('Bitlet', 'BitLet');
    addSimpleClient('AllPeers', 'AP');
    addSimpleClient('BTuga Revolution', 'BTM');
    addSimpleClient('Rufus', 'RS', 2);
    addSimpleClient('BitMagnet', 'BM', 2); // BitMagnet - predecessor to Rufus
    addSimpleClient('QVOD', 'QVOD');
    // Top-BT is based on BitTornado, but doesn't quite stick to Shadow's naming conventions,
    // so we'll use substring matching instead.
    addSimpleClient('Top-BT', 'TB');
    addSimpleClient('Tixati', 'TIX');
    // seems to have a sub-version encoded in following 3 bytes, not worked out how: "folx/1.0.456.591" : 2D 464C 3130 FF862D 486263574A43585F66314D5A
    addSimpleClient('folx', '-FL');
    addSimpleClient('\u00B5Torrent Mac', '-UM');
    addSimpleClient('\u00B5Torrent', '-UT'); // Initialize known clients...

    isInitialized = true;
  }

  final Map<String, String> azStyleClients = {};
  final Map<String, V> azStyleClientVersions = {};

  final Map<String, String> shadowStyleClients = {};
  final Map<String, V> shadowStyleClientVersions = {};

  final Map<String, String> mainlineStyleClients = {};

  final List<Map<String, dynamic>> customStyleClients = [];

  static V VER_AZ_THREE_DIGITS = (v) => "${v[0]}.${v[1]}.${v[2]}";

  static V VER_AZ_DELUGE = (v) {
    String alphabet = 'ABCDE';
    if (v.length < 3) {
      return '${v[0]}.${v[1]}.1${alphabet.indexOf(v[2])}';
    }
    return '${v[0]}.${v[1]}.${v[2]}';
  };

  static V VER_AZ_THREE_DIGITS_PLUS_MNEMONIC = (v) {
    var mnemonic = v[3];
    if (mnemonic == 'B') {
      mnemonic = 'Beta';
    } else if (mnemonic == 'A') {
      mnemonic = 'Alpha';
    } else {
      mnemonic = '';
    }
    return '${v[0]}.${v[1]}.${v[2]} $mnemonic';
  };

  static V VER_AZ_FOUR_DIGITS = (v) => '${v[0]}.${v[1]}.${v[2]}.${v[3]}';

  static V VER_AZ_TWO_MAJ_TWO_MIN = (v) => '${v[0] + v[1]}.${v[2]}${v[3]}';
  static V VER_AZ_SKIP_FIRST_ONE_MAJ_TWO_MIN = (v) => '${v[1]}.${v[2]}${v[3]}';

  static V VER_AZ_KTORRENT_STYLE = (v) => '1.2.3=[RD].4';

  static V VER_AZ_TRANSMISSION_STYLE = (v) {
    if (v[0] == '0' && v[1] == '0' && v[2] == '0') {
      return '0.${v[3]}';
    } else if (v[0] == '0' && v[1] == '0') {
      return '0.${v[2]}${v[3]}';
    }
    return "${v[0]}.${v[1]}${v[2]}${v[3] == 'Z' || v[3] == 'X' ? '+' : ''}";
  };

  static V VER_AZ_WEBTORRENT_STYLE = (v) {
    var version = '';
    if (v[0] == '0') {
      version += '${v[1]}.';
    } else {
      version += '${v[0]}${v[1]}.';
    }
    if (v[2] == '0') {
      version += v[3];
    } else {
      version += '${v[2]}${v[3]}';
    }
    return version;
  };

  static V VER_AZ_THREE_ALPHANUMERIC_DIGITS = (v) => '2.33.4';
  static V VER_NONE = (v) => 'NO_VERSION';

  Map<String, dynamic>? parsePeerId(String peerId) {
    List<int> buffer = utf8.encode(peerId);

    Map<String, dynamic>? client;

    // If the client reuses parts of the peer ID of other peers, then try to determine this
    // first (before we misidentify the client).
    if (isPossibleSpoofClient(peerId)) {
      if ((client = decodeBitSpiritClient(peerId, buffer)) != null) {
        return client;
      }
      if ((client = decodeBitCometClient(peerId, buffer)) != null) {
        return client;
      }
      return {'client': 'BitSpirit', 'version': ''};
    }

    String? clientName;

    // See if the client uses Az style identification
    if (isAzStyle(peerId)) {
      if ((clientName = getAzStyleClientName(peerId)) != null) {
        String? version = getAzStyleClientVersion(clientName!, peerId);

        // Hack for fake ZipTorrent clients - there seems to be some clients
        // which use the same identifier, but they aren't valid ZipTorrent clients
        if (clientName.startsWith('ZipTorrent') &&
            peerId.startsWith('bLAde', 8)) {
          return {'client': 'Unknown [Fake: ZipTorrent]', 'version': version};
        }

        // BitTorrent 6.0 Beta currently misidentifies itself
        if (clientName == '\u00B5Torrent' && version == '6.0 Beta') {
          return {'client': 'Mainline', 'version': version};
        }

        // If it's the rakshasa libtorrent, then it's probably rTorrent
        if (clientName.startsWith('libTorrent (Rakshasa)')) {
          return {'client': "$clientName / rTorrent", 'version': version};
        }
        return {'client': clientName, 'version': version};
      }
    }

    // See if the client uses Shadow style identification
    if (isShadowStyle(peerId)) {
      if ((clientName = getShadowStyleClientName(peerId)) != null) {
        // TODO: handle shadow style client version numbers
        return {'client': clientName, 'version': ''};
      }
    }

    // See if the client uses Mainline style identification
    if (isMainlineStyle(peerId)) {
      if ((clientName = getMainlineStyleClientName(peerId)) != null) {
        // TODO: handle mainline style client version numbers
        return {'client': clientName, 'version': ''};
      }
    }

    // Check for BitSpirit / BitComet disregarding spoof mode
    if ((client = decodeBitSpiritClient(peerId, buffer)) != null) {
      return client;
    }

    if ((client = decodeBitCometClient(peerId, buffer)) != null) {
      return client;
    }

    // See if the client identifies itself using a particular substring
    Map<String, dynamic>? data = getSimpleClient(peerId);
    if (data != null) {
      // TODO: handle simple client version numbers
      return {'client': data['client'], 'version': data['version']};
    }

    // See if client is known to be awkward / nonstandard
    if ((client = identifyAwkwardClient(peerId, buffer)) != null) {
      return client;
    }

    // TODO: handle unknown az-formatted and shadow-formatted clients
    return {'client': '', 'version': ''};
  }

  void addAzStyle(String id, String client, [dynamic version]) {
    azStyleClients[id] = client;
    V newVersion = version == null
        ? VER_AZ_FOUR_DIGITS
        : version is String
            ? (v) {
                return version;
              }
            : version as V;
    azStyleClientVersions[client] = newVersion;
  }

  void addShadowStyle(String id, String client, [dynamic version]) {
    shadowStyleClients[id] = client;
    V newVersion = version == null
        ? VER_AZ_THREE_DIGITS
        : version is String
            ? (v) {
                return version;
              }
            : version as V;
    shadowStyleClientVersions[client] = newVersion;
  }

  void addMainlineStyle(String id, String client) {
    mainlineStyleClients[id] = client;
  }

  void addSimpleClient(String client,
      [String? version, dynamic id, int? position]) {
    if (id is int || id == null) {
      position = id;
      id = version;
      version = null;
    }

    customStyleClients.add({
      'id': id,
      'client': client,
      'version': version,
      'position': position ?? 0
    });
  }

  String? getAzStyleClientName(String peerId) {
    return azStyleClients[peerId.substring(1, 3)];
  }

  String? getShadowStyleClientName(String peerId) {
    return shadowStyleClients[peerId.substring(0, 1)];
  }

  String? getMainlineStyleClientName(String peerId) {
    return mainlineStyleClients[peerId.substring(0, 1)];
  }

  Map<String, dynamic>? getSimpleClient(String peerId) {
    for (var client in customStyleClients) {
      if (peerId.startsWith(client['id'], client['position'])) {
        return client;
      }
    }

    return null;
  }

  String? getAzStyleClientVersion(String client, String peerId) {
    V? versionFunction = azStyleClientVersions[client];
    if (versionFunction == null) return null;

    return getAzStyleVersionNumber(peerId.substring(3, 7), versionFunction);
  }
}
