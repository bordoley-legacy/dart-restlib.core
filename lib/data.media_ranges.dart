library restlib.core.data.media_ranges;

import "package:restlib_common/collections.dart";

import "data.dart";

final Dictionary<String, MediaRange> DEFAULT_EXTENSION_MAP = new Dictionary.wrapMap(_DEFAUlT_EXTENSION_MAP);

const MediaRange APPLICATION_ANDREW_INSET = const MediaRange.constant("application", "andrew-inset");
const MediaRange APPLICATION_APPLIXWARE = const MediaRange.constant("application", "applixware");
const MediaRange APPLICATION_ATOMCAT_XML = const MediaRange.constant("application", "atomcat+xml");
const MediaRange APPLICATION_ATOMSVC_XML = const MediaRange.constant("application", "atomsvc+xml");
const MediaRange APPLICATION_ATOM_XML = const MediaRange.constant("application", "atom+xml");
final MediaRange APPLICATION_ATOM_XML_ENTRY = MEDIA_RANGE.parseValue("application/atom+xml;type=entry");
final MediaRange APPLICATION_ATOM_XML_FEED = MEDIA_RANGE.parseValue("application/atom+xml;type=feed");
const MediaRange APPLICATION_CCXML_XML = const MediaRange.constant("application", "ccxml+xml");
const MediaRange APPLICATION_CDMI_CAPABILITY = const MediaRange.constant("application", "cdmi-capability");
const MediaRange APPLICATION_CDMI_CONTAINER = const MediaRange.constant("application", "cdmi-container");
const MediaRange APPLICATION_CDMI_DOMAIN = const MediaRange.constant("application", "cdmi-domain");
const MediaRange APPLICATION_CDMI_OBJECT = const MediaRange.constant("application", "cdmi-object");
const MediaRange APPLICATION_CDMI_QUEUE = const MediaRange.constant("application", "cdmi-queue");
const MediaRange APPLICATION_CU_SEEME = const MediaRange.constant("application", "cu-seeme");
const MediaRange APPLICATION_DART = const MediaRange.constant("application", "dart");
const MediaRange APPLICATION_DAVMOUNT_XML = const MediaRange.constant("application", "davmount+xml");
const MediaRange APPLICATION_DOCBOOK_XML = const MediaRange.constant("application", "docbook+xml");
const MediaRange APPLICATION_DSSC_DER = const MediaRange.constant("application", "dssc+der");
const MediaRange APPLICATION_DSSC_XML = const MediaRange.constant("application", "dssc+xml");
const MediaRange APPLICATION_ECMASCRIPT = const MediaRange.constant("application", "ecmascript");
const MediaRange APPLICATION_EMMA_XML = const MediaRange.constant("application", "emma+xml");
const MediaRange APPLICATION_EPUB_ZIP = const MediaRange.constant("application", "epub+zip");
const MediaRange APPLICATION_EXI = const MediaRange.constant("application", "exi");
const MediaRange APPLICATION_FONT_TDPFR = const MediaRange.constant("application", "font-tdpfr");
const MediaRange APPLICATION_GML_XML = const MediaRange.constant("application", "gml+xml");
const MediaRange APPLICATION_GPX_XML = const MediaRange.constant("application", "gpx+xml");
const MediaRange APPLICATION_GXF = const MediaRange.constant("application", "gxf");
const MediaRange APPLICATION_HYPERSTUDIO = const MediaRange.constant("application", "hyperstudio");
const MediaRange APPLICATION_INKML_XML = const MediaRange.constant("application", "inkml+xml");
const MediaRange APPLICATION_IPFIX = const MediaRange.constant("application", "ipfix");
const MediaRange APPLICATION_JAVASCRIPT = const MediaRange.constant("application", "javascript");
const MediaRange APPLICATION_JAVA_ARCHIVE = const MediaRange.constant("application", "java-archive");
const MediaRange APPLICATION_JAVA_SERIALIZED_OBJECT = const MediaRange.constant("application", "java-serialized-object");
const MediaRange APPLICATION_JAVA_VM = const MediaRange.constant("application", "java-vm");
const MediaRange APPLICATION_JSON = const MediaRange.constant("application", "json");
const MediaRange APPLICATION_JSONML_JSON = const MediaRange.constant("application", "jsonml+json");
const MediaRange APPLICATION_LOST_XML = const MediaRange.constant("application", "lost+xml");
const MediaRange APPLICATION_MAC_BINHEX40 = const MediaRange.constant("application", "mac-binhex40");
const MediaRange APPLICATION_MAC_COMPACTPRO = const MediaRange.constant("application", "mac-compactpro");
const MediaRange APPLICATION_MADS_XML = const MediaRange.constant("application", "mads+xml");
const MediaRange APPLICATION_MARC = const MediaRange.constant("application", "marc");
const MediaRange APPLICATION_MARCXML_XML = const MediaRange.constant("application", "marcxml+xml");
const MediaRange APPLICATION_MATHEMATICA = const MediaRange.constant("application", "mathematica");
const MediaRange APPLICATION_MATHML_XML = const MediaRange.constant("application", "mathml+xml");
const MediaRange APPLICATION_MBOX = const MediaRange.constant("application", "mbox");
const MediaRange APPLICATION_MEDIASERVERCONTROL_XML = const MediaRange.constant("application", "mediaservercontrol+xml");
const MediaRange APPLICATION_METALINK4_XML = const MediaRange.constant("application", "metalink4+xml");
const MediaRange APPLICATION_METALINK_XML = const MediaRange.constant("application", "metalink+xml");
const MediaRange APPLICATION_METS_XML = const MediaRange.constant("application", "mets+xml");
const MediaRange APPLICATION_MODS_XML = const MediaRange.constant("application", "mods+xml");
const MediaRange APPLICATION_MP21 = const MediaRange.constant("application", "mp21");
const MediaRange APPLICATION_MP4 = const MediaRange.constant("application", "mp4");
const MediaRange APPLICATION_MSWORD = const MediaRange.constant("application", "msword");
const MediaRange APPLICATION_MXF = const MediaRange.constant("application", "mxf");
const MediaRange APPLICATION_OCTET_STREAM = const MediaRange.constant("application", "octet-stream");
const MediaRange APPLICATION_ODA = const MediaRange.constant("application", "oda");
const MediaRange APPLICATION_OEBPS_PACKAGE_XML = const MediaRange.constant("application", "oebps-package+xml");
const MediaRange APPLICATION_OGG = const MediaRange.constant("application", "ogg");
const MediaRange APPLICATION_OMDOC_XML = const MediaRange.constant("application", "omdoc+xml");
const MediaRange APPLICATION_ONENOTE = const MediaRange.constant("application", "onenote");
const MediaRange APPLICATION_OPEN_SEARCH_DESCRIPTION_XML = const MediaRange.constant("application", "opensearchdescription+xml");
const MediaRange APPLICATION_OXPS = const MediaRange.constant("application", "oxps");
const MediaRange APPLICATION_PATCH_OPS_ERROR_XML = const MediaRange.constant("application", "patch-ops-error+xml");
const MediaRange APPLICATION_PDF = const MediaRange.constant("application", "pdf");
const MediaRange APPLICATION_PGP_ENCRYPTED = const MediaRange.constant("application", "pgp-encrypted");
const MediaRange APPLICATION_PGP_SIGNATURE = const MediaRange.constant("application", "pgp-signature");
const MediaRange APPLICATION_PICS_RULES = const MediaRange.constant("application", "pics-rules");
const MediaRange APPLICATION_PKCS10 = const MediaRange.constant("application", "pkcs10");
const MediaRange APPLICATION_PKCS7_MIME = const MediaRange.constant("application", "pkcs7-mime");
const MediaRange APPLICATION_PKCS7_SIGNATURE = const MediaRange.constant("application", "pkcs7-signature");
const MediaRange APPLICATION_PKCS8 = const MediaRange.constant("application", "pkcs8");
const MediaRange APPLICATION_PKIXCMP = const MediaRange.constant("application", "pkixcmp");
const MediaRange APPLICATION_PKIX_ATTR_CERT = const MediaRange.constant("application", "pkix-attr-cert");
const MediaRange APPLICATION_PKIX_CERT = const MediaRange.constant("application", "pkix-cert");
const MediaRange APPLICATION_PKIX_CRL = const MediaRange.constant("application", "pkix-crl");
const MediaRange APPLICATION_PKIX_PKIPATH = const MediaRange.constant("application", "pkix-pkipath");
const MediaRange APPLICATION_PLS_XML = const MediaRange.constant("application", "pls+xml");
const MediaRange APPLICATION_POSTSCRIPT = const MediaRange.constant("application", "postscript");
const MediaRange APPLICATION_PROTOCOL_BUFFER = const MediaRange.constant("application", "x-protobuf");
const MediaRange APPLICATION_PRS_CWW = const MediaRange.constant("application", "prs.cww");
const MediaRange APPLICATION_PSKC_XML = const MediaRange.constant("application", "pskc+xml");
const MediaRange APPLICATION_RDF_XML = const MediaRange.constant("application", "rdf+xml");
const MediaRange APPLICATION_REGINFO_XML = const MediaRange.constant("application", "reginfo+xml");
const MediaRange APPLICATION_RELAX_NG_COMPACT_SYNTAX = const MediaRange.constant("application", "relax-ng-compact-syntax");
const MediaRange APPLICATION_RESOURCE_LISTS_DIFF_XML = const MediaRange.constant("application", "resource-lists-diff+xml");
const MediaRange APPLICATION_RESOURCE_LISTS_XML = const MediaRange.constant("application", "resource-lists+xml");
const MediaRange APPLICATION_RLS_SERVICES_XML = const MediaRange.constant("application", "rls-services+xml");
const MediaRange APPLICATION_RPKI_GHOSTBUSTERS = const MediaRange.constant("application", "rpki-ghostbusters");
const MediaRange APPLICATION_RPKI_MANIFEST = const MediaRange.constant("application", "rpki-manifest");
const MediaRange APPLICATION_RPKI_ROA = const MediaRange.constant("application", "rpki-roa");
const MediaRange APPLICATION_RSD_XML = const MediaRange.constant("application", "rsd+xml");
const MediaRange APPLICATION_RSS_XML = const MediaRange.constant("application", "rss+xml");
const MediaRange APPLICATION_RTF = const MediaRange.constant("application", "rtf");
const MediaRange APPLICATION_SBML_XML = const MediaRange.constant("application", "sbml+xml");
const MediaRange APPLICATION_SCVP_CV_REQUEST = const MediaRange.constant("application", "scvp-cv-request");
const MediaRange APPLICATION_SCVP_CV_RESPONSE = const MediaRange.constant("application", "scvp-cv-response");
const MediaRange APPLICATION_SCVP_VP_REQUEST = const MediaRange.constant("application", "scvp-vp-request");
const MediaRange APPLICATION_SCVP_VP_RESPONSE = const MediaRange.constant("application", "scvp-vp-response");
const MediaRange APPLICATION_SDP = const MediaRange.constant("application", "sdp");
const MediaRange APPLICATION_SET_PAYMENT_INITIATION = const MediaRange.constant("application", "set-payment-initiation");
const MediaRange APPLICATION_SET_REGISTRATION_INITIATION = const MediaRange.constant("application", "set-registration-initiation");
const MediaRange APPLICATION_SHF_XML = const MediaRange.constant("application", "shf+xml");
const MediaRange APPLICATION_SMIL_XML = const MediaRange.constant("application", "smil+xml");
const MediaRange APPLICATION_SPARQL_QUERY = const MediaRange.constant("application", "sparql-query");
const MediaRange APPLICATION_SPARQL_RESULTS_XML = const MediaRange.constant("application", "sparql-results+xml");
const MediaRange APPLICATION_SRGS = const MediaRange.constant("application", "srgs");
const MediaRange APPLICATION_SRGS_XML = const MediaRange.constant("application", "srgs+xml");
const MediaRange APPLICATION_SRU_XML = const MediaRange.constant("application", "sru+xml");
const MediaRange APPLICATION_SSDL_XML = const MediaRange.constant("application", "ssdl+xml");
const MediaRange APPLICATION_SSML_XML = const MediaRange.constant("application", "ssml+xml");
const MediaRange APPLICATION_TEI_XML = const MediaRange.constant("application", "tei+xml");
const MediaRange APPLICATION_THRAUD_XML = const MediaRange.constant("application", "thraud+xml");
const MediaRange APPLICATION_TIMESTAMPED_DATA = const MediaRange.constant("application", "timestamped-data");
const MediaRange APPLICATION_VND_3GPP2_TCAP = const MediaRange.constant("application", "vnd.3gpp2.tcap");
const MediaRange APPLICATION_VND_3GPP_PIC_BW_LARGE = const MediaRange.constant("application", "vnd.3gpp.pic-bw-large");
const MediaRange APPLICATION_VND_3GPP_PIC_BW_SMALL = const MediaRange.constant("application", "vnd.3gpp.pic-bw-small");
const MediaRange APPLICATION_VND_3GPP_PIC_BW_VAR = const MediaRange.constant("application", "vnd.3gpp.pic-bw-var");
const MediaRange APPLICATION_VND_3M_POST_IT_NOTES = const MediaRange.constant("application", "vnd.3m.post-it-notes");
const MediaRange APPLICATION_VND_ACCPAC_SIMPLY_ASO = const MediaRange.constant("application", "vnd.accpac.simply.aso");
const MediaRange APPLICATION_VND_ACCPAC_SIMPLY_IMP = const MediaRange.constant("application", "vnd.accpac.simply.imp");
const MediaRange APPLICATION_VND_ACUCOBOL = const MediaRange.constant("application", "vnd.acucobol");
const MediaRange APPLICATION_VND_ACUCORP = const MediaRange.constant("application", "vnd.acucorp");
const MediaRange APPLICATION_VND_ADOBE_AIR_APPLICATION_INSTALLER_PACKAGE_ZIP = const MediaRange.constant("application", "vnd.adobe.air-application-installer-package+zip");
const MediaRange APPLICATION_VND_ADOBE_FORMSCENTRAL_FCDT = const MediaRange.constant("application", "vnd.adobe.formscentral.fcdt");
const MediaRange APPLICATION_VND_ADOBE_FXP = const MediaRange.constant("application", "vnd.adobe.fxp");
const MediaRange APPLICATION_VND_ADOBE_XDP_XML = const MediaRange.constant("application", "vnd.adobe.xdp+xml");
const MediaRange APPLICATION_VND_ADOBE_XFDF = const MediaRange.constant("application", "vnd.adobe.xfdf");
const MediaRange APPLICATION_VND_AHEAD_SPACE = const MediaRange.constant("application", "vnd.ahead.space");
const MediaRange APPLICATION_VND_AIRZIP_FILESECURE_AZF = const MediaRange.constant("application", "vnd.airzip.filesecure.azf");
const MediaRange APPLICATION_VND_AIRZIP_FILESECURE_AZS = const MediaRange.constant("application", "vnd.airzip.filesecure.azs");
const MediaRange APPLICATION_VND_AMAZON_EBOOK = const MediaRange.constant("application", "vnd.amazon.ebook");
const MediaRange APPLICATION_VND_AMERICANDYNAMICS_ACC = const MediaRange.constant("application", "vnd.americandynamics.acc");
const MediaRange APPLICATION_VND_AMIGA_AMI = const MediaRange.constant("application", "vnd.amiga.ami");
const MediaRange APPLICATION_VND_ANDROID_PACKAGE_ARCHIVE = const MediaRange.constant("application", "vnd.android.package-archive");
const MediaRange APPLICATION_VND_ANSER_WEB_CERTIFICATE_ISSUE_INITIATION = const MediaRange.constant("application", "vnd.anser-web-certificate-issue-initiation");
const MediaRange APPLICATION_VND_ANSER_WEB_FUNDS_TRANSFER_INITIATION = const MediaRange.constant("application", "vnd.anser-web-funds-transfer-initiation");
const MediaRange APPLICATION_VND_ANTIX_GAME_COMPONENT = const MediaRange.constant("application", "vnd.antix.game-component");
const MediaRange APPLICATION_VND_APPLE_INSTALLER_XML = const MediaRange.constant("application", "vnd.apple.installer+xml");
const MediaRange APPLICATION_VND_APPLE_MPEGURL = const MediaRange.constant("application", "vnd.apple.mpegurl");
const MediaRange APPLICATION_VND_ARISTANETWORKS_SWI = const MediaRange.constant("application", "vnd.aristanetworks.swi");
const MediaRange APPLICATION_VND_ASTRAEA_SOFTWARE_IOTA = const MediaRange.constant("application", "vnd.astraea-software.iota");
const MediaRange APPLICATION_VND_AUDIOGRAPH = const MediaRange.constant("application", "vnd.audiograph");
const MediaRange APPLICATION_VND_BLUEICE_MULTIPASS = const MediaRange.constant("application", "vnd.blueice.multipass");
const MediaRange APPLICATION_VND_BMI = const MediaRange.constant("application", "vnd.bmi");
const MediaRange APPLICATION_VND_BUSINESSOBJECTS = const MediaRange.constant("application", "vnd.businessobjects");
const MediaRange APPLICATION_VND_CHEMDRAW_XML = const MediaRange.constant("application", "vnd.chemdraw+xml");
const MediaRange APPLICATION_VND_CHIPNUTS_KARAOKE_MMD = const MediaRange.constant("application", "vnd.chipnuts.karaoke-mmd");
const MediaRange APPLICATION_VND_CINDERELLA = const MediaRange.constant("application", "vnd.cinderella");
const MediaRange APPLICATION_VND_CLAYMORE = const MediaRange.constant("application", "vnd.claymore");
const MediaRange APPLICATION_VND_CLOANTO_RP9 = const MediaRange.constant("application", "vnd.cloanto.rp9");
const MediaRange APPLICATION_VND_CLONK_C4GROUP = const MediaRange.constant("application", "vnd.clonk.c4group");
const MediaRange APPLICATION_VND_CLUETRUST_CARTOMOBILE_CONFIG = const MediaRange.constant("application", "vnd.cluetrust.cartomobile-config");
const MediaRange APPLICATION_VND_CLUETRUST_CARTOMOBILE_CONFIG_PKG = const MediaRange.constant("application", "vnd.cluetrust.cartomobile-config-pkg");
const MediaRange APPLICATION_VND_COMMONSPACE = const MediaRange.constant("application", "vnd.commonspace");
const MediaRange APPLICATION_VND_CONTACT_CMSG = const MediaRange.constant("application", "vnd.contact.cmsg");
const MediaRange APPLICATION_VND_COSMOCALLER = const MediaRange.constant("application", "vnd.cosmocaller");
const MediaRange APPLICATION_VND_CRICK_CLICKER = const MediaRange.constant("application", "vnd.crick.clicker");
const MediaRange APPLICATION_VND_CRICK_CLICKER_KEYBOARD = const MediaRange.constant("application", "vnd.crick.clicker.keyboard");
const MediaRange APPLICATION_VND_CRICK_CLICKER_PALETTE = const MediaRange.constant("application", "vnd.crick.clicker.palette");
const MediaRange APPLICATION_VND_CRICK_CLICKER_TEMPLATE = const MediaRange.constant("application", "vnd.crick.clicker.template");
const MediaRange APPLICATION_VND_CRICK_CLICKER_WORDBANK = const MediaRange.constant("application", "vnd.crick.clicker.wordbank");
const MediaRange APPLICATION_VND_CRITICALTOOLS_WBS_XML = const MediaRange.constant("application", "vnd.criticaltools.wbs+xml");
const MediaRange APPLICATION_VND_CTC_POSML = const MediaRange.constant("application", "vnd.ctc-posml");
const MediaRange APPLICATION_VND_CUPS_PPD = const MediaRange.constant("application", "vnd.cups-ppd");
const MediaRange APPLICATION_VND_CURL_CAR = const MediaRange.constant("application", "vnd.curl.car");
const MediaRange APPLICATION_VND_CURL_PCURL = const MediaRange.constant("application", "vnd.curl.pcurl");
const MediaRange APPLICATION_VND_DATA_VISION_RDZ = const MediaRange.constant("application", "vnd.data-vision.rdz");
const MediaRange APPLICATION_VND_DECE_DATA = const MediaRange.constant("application", "vnd.dece.data");
const MediaRange APPLICATION_VND_DECE_TTML_XML = const MediaRange.constant("application", "vnd.dece.ttml+xml");
const MediaRange APPLICATION_VND_DECE_UNSPECIFIED = const MediaRange.constant("application", "vnd.dece.unspecified");
const MediaRange APPLICATION_VND_DECE_ZIP = const MediaRange.constant("application", "vnd.dece.zip");
const MediaRange APPLICATION_VND_DENOVO_FCSELAYOUT_LINK = const MediaRange.constant("application", "vnd.denovo.fcselayout-link");
const MediaRange APPLICATION_VND_DNA = const MediaRange.constant("application", "vnd.dna");
const MediaRange APPLICATION_VND_DOLBY_MLP = const MediaRange.constant("application", "vnd.dolby.mlp");
const MediaRange APPLICATION_VND_DPGRAPH = const MediaRange.constant("application", "vnd.dpgraph");
const MediaRange APPLICATION_VND_DREAMFACTORY = const MediaRange.constant("application", "vnd.dreamfactory");
const MediaRange APPLICATION_VND_DS_KEYPOINT = const MediaRange.constant("application", "vnd.ds-keypoint");
const MediaRange APPLICATION_VND_DVB_AIT = const MediaRange.constant("application", "vnd.dvb.ait");
const MediaRange APPLICATION_VND_DVB_SERVICE = const MediaRange.constant("application", "vnd.dvb.service");
const MediaRange APPLICATION_VND_DYNAGEO = const MediaRange.constant("application", "vnd.dynageo");
const MediaRange APPLICATION_VND_ECOWIN_CHART = const MediaRange.constant("application", "vnd.ecowin.chart");
const MediaRange APPLICATION_VND_ENLIVEN = const MediaRange.constant("application", "vnd.enliven");
const MediaRange APPLICATION_VND_EPSON_ESF = const MediaRange.constant("application", "vnd.epson.esf");
const MediaRange APPLICATION_VND_EPSON_MSF = const MediaRange.constant("application", "vnd.epson.msf");
const MediaRange APPLICATION_VND_EPSON_QUICKANIME = const MediaRange.constant("application", "vnd.epson.quickanime");
const MediaRange APPLICATION_VND_EPSON_SALT = const MediaRange.constant("application", "vnd.epson.salt");
const MediaRange APPLICATION_VND_EPSON_SSF = const MediaRange.constant("application", "vnd.epson.ssf");
const MediaRange APPLICATION_VND_ESZIGNO3_XML = const MediaRange.constant("application", "vnd.eszigno3+xml");
const MediaRange APPLICATION_VND_EZPIX_ALBUM = const MediaRange.constant("application", "vnd.ezpix-album");
const MediaRange APPLICATION_VND_EZPIX_PACKAGE = const MediaRange.constant("application", "vnd.ezpix-package");
const MediaRange APPLICATION_VND_FDF = const MediaRange.constant("application", "vnd.fdf");
const MediaRange APPLICATION_VND_FDSN_MSEED = const MediaRange.constant("application", "vnd.fdsn.mseed");
const MediaRange APPLICATION_VND_FDSN_SEED = const MediaRange.constant("application", "vnd.fdsn.seed");
const MediaRange APPLICATION_VND_FLOGRAPHIT = const MediaRange.constant("application", "vnd.flographit");
const MediaRange APPLICATION_VND_FLUXTIME_CLIP = const MediaRange.constant("application", "vnd.fluxtime.clip");
const MediaRange APPLICATION_VND_FRAMEMAKER = const MediaRange.constant("application", "vnd.framemaker");
const MediaRange APPLICATION_VND_FROGANS_FNC = const MediaRange.constant("application", "vnd.frogans.fnc");
const MediaRange APPLICATION_VND_FROGANS_LTF = const MediaRange.constant("application", "vnd.frogans.ltf");
const MediaRange APPLICATION_VND_FSC_WEBLAUNCH = const MediaRange.constant("application", "vnd.fsc.weblaunch");
const MediaRange APPLICATION_VND_FUJITSU_OASYS = const MediaRange.constant("application", "vnd.fujitsu.oasys");
const MediaRange APPLICATION_VND_FUJITSU_OASYS2 = const MediaRange.constant("application", "vnd.fujitsu.oasys2");
const MediaRange APPLICATION_VND_FUJITSU_OASYS3 = const MediaRange.constant("application", "vnd.fujitsu.oasys3");
const MediaRange APPLICATION_VND_FUJITSU_OASYSGP = const MediaRange.constant("application", "vnd.fujitsu.oasysgp");
const MediaRange APPLICATION_VND_FUJITSU_OASYSPRS = const MediaRange.constant("application", "vnd.fujitsu.oasysprs");
const MediaRange APPLICATION_VND_FUJIXEROX_DDD = const MediaRange.constant("application", "vnd.fujixerox.ddd");
const MediaRange APPLICATION_VND_FUJIXEROX_DOCUWORKS = const MediaRange.constant("application", "vnd.fujixerox.docuworks");
const MediaRange APPLICATION_VND_FUJIXEROX_DOCUWORKS_BINDER = const MediaRange.constant("application", "vnd.fujixerox.docuworks.binder");
const MediaRange APPLICATION_VND_FUZZYSHEET = const MediaRange.constant("application", "vnd.fuzzysheet");
const MediaRange APPLICATION_VND_GENOMATIX_TUXEDO = const MediaRange.constant("application", "vnd.genomatix.tuxedo");
const MediaRange APPLICATION_VND_GEOGEBRA_FILE = const MediaRange.constant("application", "vnd.geogebra.file");
const MediaRange APPLICATION_VND_GEOGEBRA_TOOL = const MediaRange.constant("application", "vnd.geogebra.tool");
const MediaRange APPLICATION_VND_GEOMETRY_EXPLORER = const MediaRange.constant("application", "vnd.geometry-explorer");
const MediaRange APPLICATION_VND_GEONEXT = const MediaRange.constant("application", "vnd.geonext");
const MediaRange APPLICATION_VND_GEOPLAN = const MediaRange.constant("application", "vnd.geoplan");
const MediaRange APPLICATION_VND_GEOSPACE = const MediaRange.constant("application", "vnd.geospace");
const MediaRange APPLICATION_VND_GMX = const MediaRange.constant("application", "vnd.gmx");
const MediaRange APPLICATION_VND_GOOGLE_EARTH_KML_XML = const MediaRange.constant("application", "vnd.google-earth.kml+xml");
const MediaRange APPLICATION_VND_GOOGLE_EARTH_KMZ = const MediaRange.constant("application", "vnd.google-earth.kmz");
const MediaRange APPLICATION_VND_GRAFEQ = const MediaRange.constant("application", "vnd.grafeq");
const MediaRange APPLICATION_VND_GROOVE_ACCOUNT = const MediaRange.constant("application", "vnd.groove-account");
const MediaRange APPLICATION_VND_GROOVE_HELP = const MediaRange.constant("application", "vnd.groove-help");
const MediaRange APPLICATION_VND_GROOVE_IDENTITY_MESSAGE = const MediaRange.constant("application", "vnd.groove-identity-message");
const MediaRange APPLICATION_VND_GROOVE_INJECTOR = const MediaRange.constant("application", "vnd.groove-injector");
const MediaRange APPLICATION_VND_GROOVE_TOOL_MESSAGE = const MediaRange.constant("application", "vnd.groove-tool-message");
const MediaRange APPLICATION_VND_GROOVE_TOOL_TEMPLATE = const MediaRange.constant("application", "vnd.groove-tool-template");
const MediaRange APPLICATION_VND_GROOVE_VCARD = const MediaRange.constant("application", "vnd.groove-vcard");
const MediaRange APPLICATION_VND_HAL_XML = const MediaRange.constant("application", "vnd.hal+xml");
const MediaRange APPLICATION_VND_HANDHELD_ENTERTAINMENT_XML = const MediaRange.constant("application", "vnd.handheld-entertainment+xml");
const MediaRange APPLICATION_VND_HBCI = const MediaRange.constant("application", "vnd.hbci");
const MediaRange APPLICATION_VND_HHE_LESSON_PLAYER = const MediaRange.constant("application", "vnd.hhe.lesson-player");
const MediaRange APPLICATION_VND_HP_HPGL = const MediaRange.constant("application", "vnd.hp-hpgl");
const MediaRange APPLICATION_VND_HP_HPID = const MediaRange.constant("application", "vnd.hp-hpid");
const MediaRange APPLICATION_VND_HP_HPS = const MediaRange.constant("application", "vnd.hp-hps");
const MediaRange APPLICATION_VND_HP_JLYT = const MediaRange.constant("application", "vnd.hp-jlyt");
const MediaRange APPLICATION_VND_HP_PCL = const MediaRange.constant("application", "vnd.hp-pcl");
const MediaRange APPLICATION_VND_HP_PCLXL = const MediaRange.constant("application", "vnd.hp-pclxl");
const MediaRange APPLICATION_VND_HYDROSTATIX_SOF_DATA = const MediaRange.constant("application", "vnd.hydrostatix.sof-data");
const MediaRange APPLICATION_VND_IBM_MINIPAY = const MediaRange.constant("application", "vnd.ibm.minipay");
const MediaRange APPLICATION_VND_IBM_MODCAP = const MediaRange.constant("application", "vnd.ibm.modcap");
const MediaRange APPLICATION_VND_IBM_RIGHTS_MANAGEMENT = const MediaRange.constant("application", "vnd.ibm.rights-management");
const MediaRange APPLICATION_VND_IBM_SECURE_CONTAINER = const MediaRange.constant("application", "vnd.ibm.secure-container");
const MediaRange APPLICATION_VND_ICCPROFILE = const MediaRange.constant("application", "vnd.iccprofile");
const MediaRange APPLICATION_VND_IGLOADER = const MediaRange.constant("application", "vnd.igloader");
const MediaRange APPLICATION_VND_IMMERVISION_IVP = const MediaRange.constant("application", "vnd.immervision-ivp");
const MediaRange APPLICATION_VND_IMMERVISION_IVU = const MediaRange.constant("application", "vnd.immervision-ivu");
const MediaRange APPLICATION_VND_INSORS_IGM = const MediaRange.constant("application", "vnd.insors.igm");
const MediaRange APPLICATION_VND_INTERCON_FORMNET = const MediaRange.constant("application", "vnd.intercon.formnet");
const MediaRange APPLICATION_VND_INTERGEO = const MediaRange.constant("application", "vnd.intergeo");
const MediaRange APPLICATION_VND_INTU_QBO = const MediaRange.constant("application", "vnd.intu.qbo");
const MediaRange APPLICATION_VND_INTU_QFX = const MediaRange.constant("application", "vnd.intu.qfx");
const MediaRange APPLICATION_VND_IPUNPLUGGED_RCPROFILE = const MediaRange.constant("application", "vnd.ipunplugged.rcprofile");
const MediaRange APPLICATION_VND_IREPOSITORY_PACKAGE_XML = const MediaRange.constant("application", "vnd.irepository.package+xml");
const MediaRange APPLICATION_VND_ISAC_FCS = const MediaRange.constant("application", "vnd.isac.fcs");
const MediaRange APPLICATION_VND_IS_XPR = const MediaRange.constant("application", "vnd.is-xpr");
const MediaRange APPLICATION_VND_JAM = const MediaRange.constant("application", "vnd.jam");
const MediaRange APPLICATION_VND_JCP_JAVAME_MIDLET_RMS = const MediaRange.constant("application", "vnd.jcp.javame.midlet-rms");
const MediaRange APPLICATION_VND_JISP = const MediaRange.constant("application", "vnd.jisp");
const MediaRange APPLICATION_VND_JOOST_JODA_ARCHIVE = const MediaRange.constant("application", "vnd.joost.joda-archive");
const MediaRange APPLICATION_VND_KAHOOTZ = const MediaRange.constant("application", "vnd.kahootz");
const MediaRange APPLICATION_VND_KDE_KARBON = const MediaRange.constant("application", "vnd.kde.karbon");
const MediaRange APPLICATION_VND_KDE_KCHART = const MediaRange.constant("application", "vnd.kde.kchart");
const MediaRange APPLICATION_VND_KDE_KFORMULA = const MediaRange.constant("application", "vnd.kde.kformula");
const MediaRange APPLICATION_VND_KDE_KIVIO = const MediaRange.constant("application", "vnd.kde.kivio");
const MediaRange APPLICATION_VND_KDE_KONTOUR = const MediaRange.constant("application", "vnd.kde.kontour");
const MediaRange APPLICATION_VND_KDE_KPRESENTER = const MediaRange.constant("application", "vnd.kde.kpresenter");
const MediaRange APPLICATION_VND_KDE_KSPREAD = const MediaRange.constant("application", "vnd.kde.kspread");
const MediaRange APPLICATION_VND_KDE_KWORD = const MediaRange.constant("application", "vnd.kde.kword");
const MediaRange APPLICATION_VND_KENAMEAAPP = const MediaRange.constant("application", "vnd.kenameaapp");
const MediaRange APPLICATION_VND_KIDSPIRATION = const MediaRange.constant("application", "vnd.kidspiration");
const MediaRange APPLICATION_VND_KINAR = const MediaRange.constant("application", "vnd.kinar");
const MediaRange APPLICATION_VND_KOAN = const MediaRange.constant("application", "vnd.koan");
const MediaRange APPLICATION_VND_KODAK_DESCRIPTOR = const MediaRange.constant("application", "vnd.kodak-descriptor");
const MediaRange APPLICATION_VND_LAS_LAS_XML = const MediaRange.constant("application", "vnd.las.las+xml");
const MediaRange APPLICATION_VND_LLAMAGRAPHICS_LIFE_BALANCE_DESKTOP = const MediaRange.constant("application", "vnd.llamagraphics.life-balance.desktop");
const MediaRange APPLICATION_VND_LLAMAGRAPHICS_LIFE_BALANCE_EXCHANGE_XML = const MediaRange.constant("application", "vnd.llamagraphics.life-balance.exchange+xml");
const MediaRange APPLICATION_VND_LOTUS_1_2_3 = const MediaRange.constant("application", "vnd.lotus-1-2-3");
const MediaRange APPLICATION_VND_LOTUS_APPROACH = const MediaRange.constant("application", "vnd.lotus-approach");
const MediaRange APPLICATION_VND_LOTUS_FREELANCE = const MediaRange.constant("application", "vnd.lotus-freelance");
const MediaRange APPLICATION_VND_LOTUS_NOTES = const MediaRange.constant("application", "vnd.lotus-notes");
const MediaRange APPLICATION_VND_LOTUS_ORGANIZER = const MediaRange.constant("application", "vnd.lotus-organizer");
const MediaRange APPLICATION_VND_LOTUS_SCREENCAM = const MediaRange.constant("application", "vnd.lotus-screencam");
const MediaRange APPLICATION_VND_LOTUS_WORDPRO = const MediaRange.constant("application", "vnd.lotus-wordpro");
const MediaRange APPLICATION_VND_MACPORTS_PORTPKG = const MediaRange.constant("application", "vnd.macports.portpkg");
const MediaRange APPLICATION_VND_MCD = const MediaRange.constant("application", "vnd.mcd");
const MediaRange APPLICATION_VND_MEDCALCDATA = const MediaRange.constant("application", "vnd.medcalcdata");
const MediaRange APPLICATION_VND_MEDIASTATION_CDKEY = const MediaRange.constant("application", "vnd.mediastation.cdkey");
const MediaRange APPLICATION_VND_MFER = const MediaRange.constant("application", "vnd.mfer");
const MediaRange APPLICATION_VND_MFMP = const MediaRange.constant("application", "vnd.mfmp");
const MediaRange APPLICATION_VND_MICROGRAFX_FLO = const MediaRange.constant("application", "vnd.micrografx.flo");
const MediaRange APPLICATION_VND_MICROGRAFX_IGX = const MediaRange.constant("application", "vnd.micrografx.igx");
const MediaRange APPLICATION_VND_MIF = const MediaRange.constant("application", "vnd.mif");
const MediaRange APPLICATION_VND_MOBIUS_DAF = const MediaRange.constant("application", "vnd.mobius.daf");
const MediaRange APPLICATION_VND_MOBIUS_DIS = const MediaRange.constant("application", "vnd.mobius.dis");
const MediaRange APPLICATION_VND_MOBIUS_MBK = const MediaRange.constant("application", "vnd.mobius.mbk");
const MediaRange APPLICATION_VND_MOBIUS_MQY = const MediaRange.constant("application", "vnd.mobius.mqy");
const MediaRange APPLICATION_VND_MOBIUS_MSL = const MediaRange.constant("application", "vnd.mobius.msl");
const MediaRange APPLICATION_VND_MOBIUS_PLC = const MediaRange.constant("application", "vnd.mobius.plc");
const MediaRange APPLICATION_VND_MOBIUS_TXF = const MediaRange.constant("application", "vnd.mobius.txf");
const MediaRange APPLICATION_VND_MOPHUN_APPLICATION = const MediaRange.constant("application", "vnd.mophun.application");
const MediaRange APPLICATION_VND_MOPHUN_CERTIFICATE = const MediaRange.constant("application", "vnd.mophun.certificate");
const MediaRange APPLICATION_VND_MOZILLA_XUL_XML = const MediaRange.constant("application", "vnd.mozilla.xul+xml");
const MediaRange APPLICATION_VND_MSEQ = const MediaRange.constant("application", "vnd.mseq");
const MediaRange APPLICATION_VND_MS_ARTGALRY = const MediaRange.constant("application", "vnd.ms-artgalry");
const MediaRange APPLICATION_VND_MS_CAB_COMPRESSED = const MediaRange.constant("application", "vnd.ms-cab-compressed");
const MediaRange APPLICATION_VND_MS_EXCEL = const MediaRange.constant("application", "vnd.ms-excel");
const MediaRange APPLICATION_VND_MS_EXCEL_ADDIN_MACROENABLED_12 = const MediaRange.constant("application", "vnd.ms-excel.addin.macroenabled.12");
const MediaRange APPLICATION_VND_MS_EXCEL_SHEET_BINARY_MACROENABLED_12 = const MediaRange.constant("application", "vnd.ms-excel.sheet.binary.macroenabled.12");
const MediaRange APPLICATION_VND_MS_EXCEL_SHEET_MACROENABLED_12 = const MediaRange.constant("application", "vnd.ms-excel.sheet.macroenabled.12");
const MediaRange APPLICATION_VND_MS_EXCEL_TEMPLATE_MACROENABLED_12 = const MediaRange.constant("application", "vnd.ms-excel.template.macroenabled.12");
const MediaRange APPLICATION_VND_MS_FONTOBJECT = const MediaRange.constant("application", "vnd.ms-fontobject");
const MediaRange APPLICATION_VND_MS_HTMLHELP = const MediaRange.constant("application", "vnd.ms-htmlhelp");
const MediaRange APPLICATION_VND_MS_IMS = const MediaRange.constant("application", "vnd.ms-ims");
const MediaRange APPLICATION_VND_MS_LRM = const MediaRange.constant("application", "vnd.ms-lrm");
const MediaRange APPLICATION_VND_MS_OFFICETHEME = const MediaRange.constant("application", "vnd.ms-officetheme");
const MediaRange APPLICATION_VND_MS_PKI_SECCAT = const MediaRange.constant("application", "vnd.ms-pki.seccat");
const MediaRange APPLICATION_VND_MS_PKI_STL = const MediaRange.constant("application", "vnd.ms-pki.stl");
const MediaRange APPLICATION_VND_MS_POWERPOINT = const MediaRange.constant("application", "vnd.ms-powerpoint");
const MediaRange APPLICATION_VND_MS_POWERPOINT_ADDIN_MACROENABLED_12 = const MediaRange.constant("application", "vnd.ms-powerpoint.addin.macroenabled.12");
const MediaRange APPLICATION_VND_MS_POWERPOINT_PRESENTATION_MACROENABLED_12 = const MediaRange.constant("application", "vnd.ms-powerpoint.presentation.macroenabled.12");
const MediaRange APPLICATION_VND_MS_POWERPOINT_SLIDESHOW_MACROENABLED_12 = const MediaRange.constant("application", "vnd.ms-powerpoint.slideshow.macroenabled.12");
const MediaRange APPLICATION_VND_MS_POWERPOINT_SLIDE_MACROENABLED_12 = const MediaRange.constant("application", "vnd.ms-powerpoint.slide.macroenabled.12");
const MediaRange APPLICATION_VND_MS_POWERPOINT_TEMPLATE_MACROENABLED_12 = const MediaRange.constant("application", "vnd.ms-powerpoint.template.macroenabled.12");
const MediaRange APPLICATION_VND_MS_PROJECT = const MediaRange.constant("application", "vnd.ms-project");
const MediaRange APPLICATION_VND_MS_WORD_DOCUMENT_MACROENABLED_12 = const MediaRange.constant("application", "vnd.ms-word.document.macroenabled.12");
const MediaRange APPLICATION_VND_MS_WORD_TEMPLATE_MACROENABLED_12 = const MediaRange.constant("application", "vnd.ms-word.template.macroenabled.12");
const MediaRange APPLICATION_VND_MS_WORKS = const MediaRange.constant("application", "vnd.ms-works");
const MediaRange APPLICATION_VND_MS_WPL = const MediaRange.constant("application", "vnd.ms-wpl");
const MediaRange APPLICATION_VND_MS_XPSDOCUMENT = const MediaRange.constant("application", "vnd.ms-xpsdocument");
const MediaRange APPLICATION_VND_MUSICIAN = const MediaRange.constant("application", "vnd.musician");
const MediaRange APPLICATION_VND_MUVEE_STYLE = const MediaRange.constant("application", "vnd.muvee.style");
const MediaRange APPLICATION_VND_MYNFC = const MediaRange.constant("application", "vnd.mynfc");
const MediaRange APPLICATION_VND_NEUROLANGUAGE_NLU = const MediaRange.constant("application", "vnd.neurolanguage.nlu");
const MediaRange APPLICATION_VND_NITF = const MediaRange.constant("application", "vnd.nitf");
const MediaRange APPLICATION_VND_NOBLENET_DIRECTORY = const MediaRange.constant("application", "vnd.noblenet-directory");
const MediaRange APPLICATION_VND_NOBLENET_SEALER = const MediaRange.constant("application", "vnd.noblenet-sealer");
const MediaRange APPLICATION_VND_NOBLENET_WEB = const MediaRange.constant("application", "vnd.noblenet-web");
const MediaRange APPLICATION_VND_NOKIA_N_GAGE_DATA = const MediaRange.constant("application", "vnd.nokia.n-gage.data");
const MediaRange APPLICATION_VND_NOKIA_N_GAGE_SYMBIAN_INSTALL = const MediaRange.constant("application", "vnd.nokia.n-gage.symbian.install");
const MediaRange APPLICATION_VND_NOKIA_RADIO_PRESET = const MediaRange.constant("application", "vnd.nokia.radio-preset");
const MediaRange APPLICATION_VND_NOKIA_RADIO_PRESETS = const MediaRange.constant("application", "vnd.nokia.radio-presets");
const MediaRange APPLICATION_VND_NOVADIGM_EDM = const MediaRange.constant("application", "vnd.novadigm.edm");
const MediaRange APPLICATION_VND_NOVADIGM_EDX = const MediaRange.constant("application", "vnd.novadigm.edx");
const MediaRange APPLICATION_VND_NOVADIGM_EXT = const MediaRange.constant("application", "vnd.novadigm.ext");
const MediaRange APPLICATION_VND_OASIS_OPENDOCUMENT_CHART = const MediaRange.constant("application", "vnd.oasis.opendocument.chart");
const MediaRange APPLICATION_VND_OASIS_OPENDOCUMENT_CHART_TEMPLATE = const MediaRange.constant("application", "vnd.oasis.opendocument.chart-template");
const MediaRange APPLICATION_VND_OASIS_OPENDOCUMENT_DATABASE = const MediaRange.constant("application", "vnd.oasis.opendocument.database");
const MediaRange APPLICATION_VND_OASIS_OPENDOCUMENT_FORMULA = const MediaRange.constant("application", "vnd.oasis.opendocument.formula");
const MediaRange APPLICATION_VND_OASIS_OPENDOCUMENT_FORMULA_TEMPLATE = const MediaRange.constant("application", "vnd.oasis.opendocument.formula-template");
const MediaRange APPLICATION_VND_OASIS_OPENDOCUMENT_GRAPHICS = const MediaRange.constant("application", "vnd.oasis.opendocument.graphics");
const MediaRange APPLICATION_VND_OASIS_OPENDOCUMENT_GRAPHICS_TEMPLATE = const MediaRange.constant("application", "vnd.oasis.opendocument.graphics-template");
const MediaRange APPLICATION_VND_OASIS_OPENDOCUMENT_IMAGE = const MediaRange.constant("application", "vnd.oasis.opendocument.image");
const MediaRange APPLICATION_VND_OASIS_OPENDOCUMENT_IMAGE_TEMPLATE = const MediaRange.constant("application", "vnd.oasis.opendocument.image-template");
const MediaRange APPLICATION_VND_OASIS_OPENDOCUMENT_PRESENTATION = const MediaRange.constant("application", "vnd.oasis.opendocument.presentation");
const MediaRange APPLICATION_VND_OASIS_OPENDOCUMENT_PRESENTATION_TEMPLATE = const MediaRange.constant("application", "vnd.oasis.opendocument.presentation-template");
const MediaRange APPLICATION_VND_OASIS_OPENDOCUMENT_SPREADSHEET = const MediaRange.constant("application", "vnd.oasis.opendocument.spreadsheet");
const MediaRange APPLICATION_VND_OASIS_OPENDOCUMENT_SPREADSHEET_TEMPLATE = const MediaRange.constant("application", "vnd.oasis.opendocument.spreadsheet-template");
const MediaRange APPLICATION_VND_OASIS_OPENDOCUMENT_TEXT = const MediaRange.constant("application", "vnd.oasis.opendocument.text");
const MediaRange APPLICATION_VND_OASIS_OPENDOCUMENT_TEXT_MASTER = const MediaRange.constant("application", "vnd.oasis.opendocument.text-master");
const MediaRange APPLICATION_VND_OASIS_OPENDOCUMENT_TEXT_TEMPLATE = const MediaRange.constant("application", "vnd.oasis.opendocument.text-template");
const MediaRange APPLICATION_VND_OASIS_OPENDOCUMENT_TEXT_WEB = const MediaRange.constant("application", "vnd.oasis.opendocument.text-web");
const MediaRange APPLICATION_VND_OLPC_SUGAR = const MediaRange.constant("application", "vnd.olpc-sugar");
const MediaRange APPLICATION_VND_OMA_DD2_XML = const MediaRange.constant("application", "vnd.oma.dd2+xml");
const MediaRange APPLICATION_VND_OPENOFFICEORG_EXTENSION = const MediaRange.constant("application", "vnd.openofficeorg.extension");
const MediaRange APPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_PRESENTATIONML_PRESENTATION = const MediaRange.constant("application", "vnd.openxmlformats-officedocument.presentationml.presentation");
const MediaRange APPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_PRESENTATIONML_SLIDE = const MediaRange.constant("application", "vnd.openxmlformats-officedocument.presentationml.slide");
const MediaRange APPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_PRESENTATIONML_SLIDESHOW = const MediaRange.constant("application", "vnd.openxmlformats-officedocument.presentationml.slideshow");
const MediaRange APPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_PRESENTATIONML_TEMPLATE = const MediaRange.constant("application", "vnd.openxmlformats-officedocument.presentationml.template");
const MediaRange APPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_SPREADSHEETML_SHEET = const MediaRange.constant("application", "vnd.openxmlformats-officedocument.spreadsheetml.sheet");
const MediaRange APPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_SPREADSHEETML_TEMPLATE = const MediaRange.constant("application", "vnd.openxmlformats-officedocument.spreadsheetml.template");
const MediaRange APPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_WORDPROCESSINGML_DOCUMENT = const MediaRange.constant("application", "vnd.openxmlformats-officedocument.wordprocessingml.document");
const MediaRange APPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_WORDPROCESSINGML_TEMPLATE = const MediaRange.constant("application", "vnd.openxmlformats-officedocument.wordprocessingml.template");
const MediaRange APPLICATION_VND_OSGEO_MAPGUIDE_PACKAGE = const MediaRange.constant("application", "vnd.osgeo.mapguide.package");
const MediaRange APPLICATION_VND_OSGI_DP = const MediaRange.constant("application", "vnd.osgi.dp");
const MediaRange APPLICATION_VND_OSGI_SUBSYSTEM = const MediaRange.constant("application", "vnd.osgi.subsystem");
const MediaRange APPLICATION_VND_PALM = const MediaRange.constant("application", "vnd.palm");
const MediaRange APPLICATION_VND_PAWAAFILE = const MediaRange.constant("application", "vnd.pawaafile");
const MediaRange APPLICATION_VND_PG_FORMAT = const MediaRange.constant("application", "vnd.pg.format");
const MediaRange APPLICATION_VND_PG_OSASLI = const MediaRange.constant("application", "vnd.pg.osasli");
const MediaRange APPLICATION_VND_PICSEL = const MediaRange.constant("application", "vnd.picsel");
const MediaRange APPLICATION_VND_PMI_WIDGET = const MediaRange.constant("application", "vnd.pmi.widget");
const MediaRange APPLICATION_VND_POCKETLEARN = const MediaRange.constant("application", "vnd.pocketlearn");
const MediaRange APPLICATION_VND_POWERBUILDER6 = const MediaRange.constant("application", "vnd.powerbuilder6");
const MediaRange APPLICATION_VND_PREVIEWSYSTEMS_BOX = const MediaRange.constant("application", "vnd.previewsystems.box");
const MediaRange APPLICATION_VND_PROTEUS_MAGAZINE = const MediaRange.constant("application", "vnd.proteus.magazine");
const MediaRange APPLICATION_VND_PUBLISHARE_DELTA_TREE = const MediaRange.constant("application", "vnd.publishare-delta-tree");
const MediaRange APPLICATION_VND_PVI_PTID1 = const MediaRange.constant("application", "vnd.pvi.ptid1");
const MediaRange APPLICATION_VND_QUARK_QUARKXPRESS = const MediaRange.constant("application", "vnd.quark.quarkxpress");
const MediaRange APPLICATION_VND_REALVNC_BED = const MediaRange.constant("application", "vnd.realvnc.bed");
const MediaRange APPLICATION_VND_RECORDARE_MUSICXML = const MediaRange.constant("application", "vnd.recordare.musicxml");
const MediaRange APPLICATION_VND_RECORDARE_MUSICXML_XML = const MediaRange.constant("application", "vnd.recordare.musicxml+xml");
const MediaRange APPLICATION_VND_RIG_CRYPTONOTE = const MediaRange.constant("application", "vnd.rig.cryptonote");
const MediaRange APPLICATION_VND_RIM_COD = const MediaRange.constant("application", "vnd.rim.cod");
const MediaRange APPLICATION_VND_RN_REALMEDIA = const MediaRange.constant("application", "vnd.rn-realmedia");
const MediaRange APPLICATION_VND_RN_REALMEDIA_VBR = const MediaRange.constant("application", "vnd.rn-realmedia-vbr");
const MediaRange APPLICATION_VND_ROUTE66_LINK66_XML = const MediaRange.constant("application", "vnd.route66.link66+xml");
const MediaRange APPLICATION_VND_SAILINGTRACKER_TRACK = const MediaRange.constant("application", "vnd.sailingtracker.track");
const MediaRange APPLICATION_VND_SEEMAIL = const MediaRange.constant("application", "vnd.seemail");
const MediaRange APPLICATION_VND_SEMA = const MediaRange.constant("application", "vnd.sema");
const MediaRange APPLICATION_VND_SEMD = const MediaRange.constant("application", "vnd.semd");
const MediaRange APPLICATION_VND_SEMF = const MediaRange.constant("application", "vnd.semf");
const MediaRange APPLICATION_VND_SHANA_INFORMED_FORMDATA = const MediaRange.constant("application", "vnd.shana.informed.formdata");
const MediaRange APPLICATION_VND_SHANA_INFORMED_FORMTEMPLATE = const MediaRange.constant("application", "vnd.shana.informed.formtemplate");
const MediaRange APPLICATION_VND_SHANA_INFORMED_INTERCHANGE = const MediaRange.constant("application", "vnd.shana.informed.interchange");
const MediaRange APPLICATION_VND_SHANA_INFORMED_PACKAGE = const MediaRange.constant("application", "vnd.shana.informed.package");
const MediaRange APPLICATION_VND_SIMTECH_MINDMAPPER = const MediaRange.constant("application", "vnd.simtech-mindmapper");
const MediaRange APPLICATION_VND_SMAF = const MediaRange.constant("application", "vnd.smaf");
const MediaRange APPLICATION_VND_SMART_TEACHER = const MediaRange.constant("application", "vnd.smart.teacher");
const MediaRange APPLICATION_VND_SOLENT_SDKM_XML = const MediaRange.constant("application", "vnd.solent.sdkm+xml");
const MediaRange APPLICATION_VND_SPOTFIRE_DXP = const MediaRange.constant("application", "vnd.spotfire.dxp");
const MediaRange APPLICATION_VND_SPOTFIRE_SFS = const MediaRange.constant("application", "vnd.spotfire.sfs");
const MediaRange APPLICATION_VND_STARDIVISION_CALC = const MediaRange.constant("application", "vnd.stardivision.calc");
const MediaRange APPLICATION_VND_STARDIVISION_DRAW = const MediaRange.constant("application", "vnd.stardivision.draw");
const MediaRange APPLICATION_VND_STARDIVISION_IMPRESS = const MediaRange.constant("application", "vnd.stardivision.impress");
const MediaRange APPLICATION_VND_STARDIVISION_MATH = const MediaRange.constant("application", "vnd.stardivision.math");
const MediaRange APPLICATION_VND_STARDIVISION_WRITER = const MediaRange.constant("application", "vnd.stardivision.writer");
const MediaRange APPLICATION_VND_STARDIVISION_WRITER_GLOBAL = const MediaRange.constant("application", "vnd.stardivision.writer-global");
const MediaRange APPLICATION_VND_STEPMANIA_PACKAGE = const MediaRange.constant("application", "vnd.stepmania.package");
const MediaRange APPLICATION_VND_STEPMANIA_STEPCHART = const MediaRange.constant("application", "vnd.stepmania.stepchart");
const MediaRange APPLICATION_VND_SUN_XML_CALC = const MediaRange.constant("application", "vnd.sun.xml.calc");
const MediaRange APPLICATION_VND_SUN_XML_CALC_TEMPLATE = const MediaRange.constant("application", "vnd.sun.xml.calc.template");
const MediaRange APPLICATION_VND_SUN_XML_DRAW = const MediaRange.constant("application", "vnd.sun.xml.draw");
const MediaRange APPLICATION_VND_SUN_XML_DRAW_TEMPLATE = const MediaRange.constant("application", "vnd.sun.xml.draw.template");
const MediaRange APPLICATION_VND_SUN_XML_IMPRESS = const MediaRange.constant("application", "vnd.sun.xml.impress");
const MediaRange APPLICATION_VND_SUN_XML_IMPRESS_TEMPLATE = const MediaRange.constant("application", "vnd.sun.xml.impress.template");
const MediaRange APPLICATION_VND_SUN_XML_MATH = const MediaRange.constant("application", "vnd.sun.xml.math");
const MediaRange APPLICATION_VND_SUN_XML_WRITER = const MediaRange.constant("application", "vnd.sun.xml.writer");
const MediaRange APPLICATION_VND_SUN_XML_WRITER_GLOBAL = const MediaRange.constant("application", "vnd.sun.xml.writer.global");
const MediaRange APPLICATION_VND_SUN_XML_WRITER_TEMPLATE = const MediaRange.constant("application", "vnd.sun.xml.writer.template");
const MediaRange APPLICATION_VND_SUS_CALENDAR = const MediaRange.constant("application", "vnd.sus-calendar");
const MediaRange APPLICATION_VND_SVD = const MediaRange.constant("application", "vnd.svd");
const MediaRange APPLICATION_VND_SYMBIAN_INSTALL = const MediaRange.constant("application", "vnd.symbian.install");
const MediaRange APPLICATION_VND_SYNCML_DM_WBXML = const MediaRange.constant("application", "vnd.syncml.dm+wbxml");
const MediaRange APPLICATION_VND_SYNCML_DM_XML = const MediaRange.constant("application", "vnd.syncml.dm+xml");
const MediaRange APPLICATION_VND_SYNCML_XML = const MediaRange.constant("application", "vnd.syncml+xml");
const MediaRange APPLICATION_VND_TAO_INTENT_MODULE_ARCHIVE = const MediaRange.constant("application", "vnd.tao.intent-module-archive");
const MediaRange APPLICATION_VND_TCPDUMP_PCAP = const MediaRange.constant("application", "vnd.tcpdump.pcap");
const MediaRange APPLICATION_VND_TMOBILE_LIVETV = const MediaRange.constant("application", "vnd.tmobile-livetv");
const MediaRange APPLICATION_VND_TRID_TPT = const MediaRange.constant("application", "vnd.trid.tpt");
const MediaRange APPLICATION_VND_TRISCAPE_MXS = const MediaRange.constant("application", "vnd.triscape.mxs");
const MediaRange APPLICATION_VND_TRUEAPP = const MediaRange.constant("application", "vnd.trueapp");
const MediaRange APPLICATION_VND_UFDL = const MediaRange.constant("application", "vnd.ufdl");
const MediaRange APPLICATION_VND_UIQ_THEME = const MediaRange.constant("application", "vnd.uiq.theme");
const MediaRange APPLICATION_VND_UMAJIN = const MediaRange.constant("application", "vnd.umajin");
const MediaRange APPLICATION_VND_UNITY = const MediaRange.constant("application", "vnd.unity");
const MediaRange APPLICATION_VND_UOML_XML = const MediaRange.constant("application", "vnd.uoml+xml");
const MediaRange APPLICATION_VND_VCX = const MediaRange.constant("application", "vnd.vcx");
const MediaRange APPLICATION_VND_VISIO = const MediaRange.constant("application", "vnd.visio");
const MediaRange APPLICATION_VND_VISIONARY = const MediaRange.constant("application", "vnd.visionary");
const MediaRange APPLICATION_VND_VSF = const MediaRange.constant("application", "vnd.vsf");
const MediaRange APPLICATION_VND_WAP_WBXML = const MediaRange.constant("application", "vnd.wap.wbxml");
const MediaRange APPLICATION_VND_WAP_WMLC = const MediaRange.constant("application", "vnd.wap.wmlc");
const MediaRange APPLICATION_VND_WAP_WMLSCRIPTC = const MediaRange.constant("application", "vnd.wap.wmlscriptc");
const MediaRange APPLICATION_VND_WEBTURBO = const MediaRange.constant("application", "vnd.webturbo");
const MediaRange APPLICATION_VND_WOLFRAM_PLAYER = const MediaRange.constant("application", "vnd.wolfram.player");
const MediaRange APPLICATION_VND_WORDPERFECT = const MediaRange.constant("application", "vnd.wordperfect");
const MediaRange APPLICATION_VND_WQD = const MediaRange.constant("application", "vnd.wqd");
const MediaRange APPLICATION_VND_WT_STF = const MediaRange.constant("application", "vnd.wt.stf");
const MediaRange APPLICATION_VND_XARA = const MediaRange.constant("application", "vnd.xara");
const MediaRange APPLICATION_VND_XFDL = const MediaRange.constant("application", "vnd.xfdl");
const MediaRange APPLICATION_VND_YAMAHA_HV_DIC = const MediaRange.constant("application", "vnd.yamaha.hv-dic");
const MediaRange APPLICATION_VND_YAMAHA_HV_SCRIPT = const MediaRange.constant("application", "vnd.yamaha.hv-script");
const MediaRange APPLICATION_VND_YAMAHA_HV_VOICE = const MediaRange.constant("application", "vnd.yamaha.hv-voice");
const MediaRange APPLICATION_VND_YAMAHA_OPENSCOREFORMAT = const MediaRange.constant("application", "vnd.yamaha.openscoreformat");
const MediaRange APPLICATION_VND_YAMAHA_OPENSCOREFORMAT_OSFPVG_XML = const MediaRange.constant("application", "vnd.yamaha.openscoreformat.osfpvg+xml");
const MediaRange APPLICATION_VND_YAMAHA_SMAF_AUDIO = const MediaRange.constant("application", "vnd.yamaha.smaf-audio");
const MediaRange APPLICATION_VND_YAMAHA_SMAF_PHRASE = const MediaRange.constant("application", "vnd.yamaha.smaf-phrase");
const MediaRange APPLICATION_VND_YELLOWRIVER_CUSTOM_MENU = const MediaRange.constant("application", "vnd.yellowriver-custom-menu");
const MediaRange APPLICATION_VND_ZUL = const MediaRange.constant("application", "vnd.zul");
const MediaRange APPLICATION_VND_ZZAZZ_DECK_XML = const MediaRange.constant("application", "vnd.zzazz.deck+xml");
const MediaRange APPLICATION_VOICEXML_XML = const MediaRange.constant("application", "voicexml+xml");
const MediaRange APPLICATION_WIDGET = const MediaRange.constant("application", "widget");
const MediaRange APPLICATION_WINHLP = const MediaRange.constant("application", "winhlp");
const MediaRange APPLICATION_WSDL_XML = const MediaRange.constant("application", "wsdl+xml");
const MediaRange APPLICATION_WSPOLICY_XML = const MediaRange.constant("application", "wspolicy+xml");
const MediaRange APPLICATION_WWW_FORM = const MediaRange.constant("application", "x-www-form-urlencoded");
const MediaRange APPLICATION_XAML_XML = const MediaRange.constant("application", "xaml+xml");
const MediaRange APPLICATION_XCAP_DIFF_XML = const MediaRange.constant("application", "xcap-diff+xml");
const MediaRange APPLICATION_XENC_XML = const MediaRange.constant("application", "xenc+xml");
const MediaRange APPLICATION_XHTML_XML = const MediaRange.constant("application", "xhtml+xml");
const MediaRange APPLICATION_XML = const MediaRange.constant("application", "xml");
const MediaRange APPLICATION_XML_DTD = const MediaRange.constant("application", "xml-dtd");
const MediaRange APPLICATION_XOP_XML = const MediaRange.constant("application", "xop+xml");
const MediaRange APPLICATION_XPROC_XML = const MediaRange.constant("application", "xproc+xml");
const MediaRange APPLICATION_XSLT_XML = const MediaRange.constant("application", "xslt+xml");
const MediaRange APPLICATION_XSPF_XML = const MediaRange.constant("application", "xspf+xml");
const MediaRange APPLICATION_XV_XML = const MediaRange.constant("application", "xv+xml");
const MediaRange APPLICATION_X_7Z_COMPRESSED = const MediaRange.constant("application", "x-7z-compressed");
const MediaRange APPLICATION_X_ABIWORD = const MediaRange.constant("application", "x-abiword");
const MediaRange APPLICATION_X_ACE_COMPRESSED = const MediaRange.constant("application", "x-ace-compressed");
const MediaRange APPLICATION_X_APPLE_DISKIMAGE = const MediaRange.constant("application", "x-apple-diskimage");
const MediaRange APPLICATION_X_AUTHORWARE_BIN = const MediaRange.constant("application", "x-authorware-bin");
const MediaRange APPLICATION_X_AUTHORWARE_MAP = const MediaRange.constant("application", "x-authorware-map");
const MediaRange APPLICATION_X_AUTHORWARE_SEG = const MediaRange.constant("application", "x-authorware-seg");
const MediaRange APPLICATION_X_BCPIO = const MediaRange.constant("application", "x-bcpio");
const MediaRange APPLICATION_X_BITTORRENT = const MediaRange.constant("application", "x-bittorrent");
const MediaRange APPLICATION_X_BLORB = const MediaRange.constant("application", "x-blorb");
const MediaRange APPLICATION_X_BZIP = const MediaRange.constant("application", "x-bzip");
const MediaRange APPLICATION_X_BZIP2 = const MediaRange.constant("application", "x-bzip2");
const MediaRange APPLICATION_X_CBR = const MediaRange.constant("application", "x-cbr");
const MediaRange APPLICATION_X_CDLINK = const MediaRange.constant("application", "x-cdlink");
const MediaRange APPLICATION_X_CFS_COMPRESSED = const MediaRange.constant("application", "x-cfs-compressed");
const MediaRange APPLICATION_X_CHAT = const MediaRange.constant("application", "x-chat");
const MediaRange APPLICATION_X_CHESS_PGN = const MediaRange.constant("application", "x-chess-pgn");
const MediaRange APPLICATION_X_CONFERENCE = const MediaRange.constant("application", "x-conference");
const MediaRange APPLICATION_X_CPIO = const MediaRange.constant("application", "x-cpio");
const MediaRange APPLICATION_X_CSH = const MediaRange.constant("application", "x-csh");
const MediaRange APPLICATION_X_DEBIAN_PACKAGE = const MediaRange.constant("application", "x-debian-package");
const MediaRange APPLICATION_X_DGC_COMPRESSED = const MediaRange.constant("application", "x-dgc-compressed");
const MediaRange APPLICATION_X_DIRECTOR = const MediaRange.constant("application", "x-director");
const MediaRange APPLICATION_X_DOOM = const MediaRange.constant("application", "x-doom");
const MediaRange APPLICATION_X_DTBNCX_XML = const MediaRange.constant("application", "x-dtbncx+xml");
const MediaRange APPLICATION_X_DTBOOK_XML = const MediaRange.constant("application", "x-dtbook+xml");
const MediaRange APPLICATION_X_DTBRESOURCE_XML = const MediaRange.constant("application", "x-dtbresource+xml");
const MediaRange APPLICATION_X_DVI = const MediaRange.constant("application", "x-dvi");
const MediaRange APPLICATION_X_ENVOY = const MediaRange.constant("application", "x-envoy");
const MediaRange APPLICATION_X_EVA = const MediaRange.constant("application", "x-eva");
const MediaRange APPLICATION_X_FONT_BDF = const MediaRange.constant("application", "x-font-bdf");
const MediaRange APPLICATION_X_FONT_GHOSTSCRIPT = const MediaRange.constant("application", "x-font-ghostscript");
const MediaRange APPLICATION_X_FONT_LINUX_PSF = const MediaRange.constant("application", "x-font-linux-psf");
const MediaRange APPLICATION_X_FONT_OTF = const MediaRange.constant("application", "x-font-otf");
const MediaRange APPLICATION_X_FONT_PCF = const MediaRange.constant("application", "x-font-pcf");
const MediaRange APPLICATION_X_FONT_SNF = const MediaRange.constant("application", "x-font-snf");
const MediaRange APPLICATION_X_FONT_TTF = const MediaRange.constant("application", "x-font-ttf");
const MediaRange APPLICATION_X_FONT_TYPE1 = const MediaRange.constant("application", "x-font-type1");
const MediaRange APPLICATION_X_FONT_WOFF = const MediaRange.constant("application", "x-font-woff");
const MediaRange APPLICATION_X_FREEARC = const MediaRange.constant("application", "x-freearc");
const MediaRange APPLICATION_X_FUTURESPLASH = const MediaRange.constant("application", "x-futuresplash");
const MediaRange APPLICATION_X_GCA_COMPRESSED = const MediaRange.constant("application", "x-gca-compressed");
const MediaRange APPLICATION_X_GLULX = const MediaRange.constant("application", "x-glulx");
const MediaRange APPLICATION_X_GNUMERIC = const MediaRange.constant("application", "x-gnumeric");
const MediaRange APPLICATION_X_GRAMPS_XML = const MediaRange.constant("application", "x-gramps-xml");
const MediaRange APPLICATION_X_GTAR = const MediaRange.constant("application", "x-gtar");
const MediaRange APPLICATION_X_HDF = const MediaRange.constant("application", "x-hdf");
const MediaRange APPLICATION_X_INSTALL_INSTRUCTIONS = const MediaRange.constant("application", "x-install-instructions");
const MediaRange APPLICATION_X_ISO9660_IMAGE = const MediaRange.constant("application", "x-iso9660-image");
const MediaRange APPLICATION_X_JAVA_JNLP_FILE = const MediaRange.constant("application", "x-java-jnlp-file");
const MediaRange APPLICATION_X_LATEX = const MediaRange.constant("application", "x-latex");
const MediaRange APPLICATION_X_LZH_COMPRESSED = const MediaRange.constant("application", "x-lzh-compressed");
const MediaRange APPLICATION_X_MIE = const MediaRange.constant("application", "x-mie");
const MediaRange APPLICATION_X_MOBIPOCKET_EBOOK = const MediaRange.constant("application", "x-mobipocket-ebook");
const MediaRange APPLICATION_X_MSACCESS = const MediaRange.constant("application", "x-msaccess");
const MediaRange APPLICATION_X_MSBINDER = const MediaRange.constant("application", "x-msbinder");
const MediaRange APPLICATION_X_MSCARDFILE = const MediaRange.constant("application", "x-mscardfile");
const MediaRange APPLICATION_X_MSCLIP = const MediaRange.constant("application", "x-msclip");
const MediaRange APPLICATION_X_MSDOWNLOAD = const MediaRange.constant("application", "x-msdownload");
const MediaRange APPLICATION_X_MSMEDIAVIEW = const MediaRange.constant("application", "x-msmediaview");
const MediaRange APPLICATION_X_MSMETAFILE = const MediaRange.constant("application", "x-msmetafile");
const MediaRange APPLICATION_X_MSMONEY = const MediaRange.constant("application", "x-msmoney");
const MediaRange APPLICATION_X_MSPUBLISHER = const MediaRange.constant("application", "x-mspublisher");
const MediaRange APPLICATION_X_MSSCHEDULE = const MediaRange.constant("application", "x-msschedule");
const MediaRange APPLICATION_X_MSTERMINAL = const MediaRange.constant("application", "x-msterminal");
const MediaRange APPLICATION_X_MSWRITE = const MediaRange.constant("application", "x-mswrite");
const MediaRange APPLICATION_X_MS_APPLICATION = const MediaRange.constant("application", "x-ms-application");
const MediaRange APPLICATION_X_MS_SHORTCUT = const MediaRange.constant("application", "x-ms-shortcut");
const MediaRange APPLICATION_X_MS_WMD = const MediaRange.constant("application", "x-ms-wmd");
const MediaRange APPLICATION_X_MS_WMZ = const MediaRange.constant("application", "x-ms-wmz");
const MediaRange APPLICATION_X_MS_XBAP = const MediaRange.constant("application", "x-ms-xbap");
const MediaRange APPLICATION_X_NETCDF = const MediaRange.constant("application", "x-netcdf");
const MediaRange APPLICATION_X_NZB = const MediaRange.constant("application", "x-nzb");
const MediaRange APPLICATION_X_PKCS12 = const MediaRange.constant("application", "x-pkcs12");
const MediaRange APPLICATION_X_PKCS7_CERTIFICATES = const MediaRange.constant("application", "x-pkcs7-certificates");
const MediaRange APPLICATION_X_PKCS7_CERTREQRESP = const MediaRange.constant("application", "x-pkcs7-certreqresp");
const MediaRange APPLICATION_X_RAR_COMPRESSED = const MediaRange.constant("application", "x-rar-compressed");
const MediaRange APPLICATION_X_RESEARCH_INFO_SYSTEMS = const MediaRange.constant("application", "x-research-info-systems");
const MediaRange APPLICATION_X_SH = const MediaRange.constant("application", "x-sh");
const MediaRange APPLICATION_X_SHAR = const MediaRange.constant("application", "x-shar");
const MediaRange APPLICATION_X_SHOCKWAVE_FLASH = const MediaRange.constant("application", "x-shockwave-flash");
const MediaRange APPLICATION_X_SILVERLIGHT_APP = const MediaRange.constant("application", "x-silverlight-app");
const MediaRange APPLICATION_X_SQL = const MediaRange.constant("application", "x-sql");
const MediaRange APPLICATION_X_STUFFIT = const MediaRange.constant("application", "x-stuffit");
const MediaRange APPLICATION_X_STUFFITX = const MediaRange.constant("application", "x-stuffitx");
const MediaRange APPLICATION_X_SUBRIP = const MediaRange.constant("application", "x-subrip");
const MediaRange APPLICATION_X_SV4CPIO = const MediaRange.constant("application", "x-sv4cpio");
const MediaRange APPLICATION_X_SV4CRC = const MediaRange.constant("application", "x-sv4crc");
const MediaRange APPLICATION_X_T3VM_IMAGE = const MediaRange.constant("application", "x-t3vm-image");
const MediaRange APPLICATION_X_TADS = const MediaRange.constant("application", "x-tads");
const MediaRange APPLICATION_X_TAR = const MediaRange.constant("application", "x-tar");
const MediaRange APPLICATION_X_TCL = const MediaRange.constant("application", "x-tcl");
const MediaRange APPLICATION_X_TEX = const MediaRange.constant("application", "x-tex");
const MediaRange APPLICATION_X_TEXINFO = const MediaRange.constant("application", "x-texinfo");
const MediaRange APPLICATION_X_TEX_TFM = const MediaRange.constant("application", "x-tex-tfm");
const MediaRange APPLICATION_X_TGIF = const MediaRange.constant("application", "x-tgif");
const MediaRange APPLICATION_X_USTAR = const MediaRange.constant("application", "x-ustar");
const MediaRange APPLICATION_X_WAIS_SOURCE = const MediaRange.constant("application", "x-wais-source");
const MediaRange APPLICATION_X_X509_CA_CERT = const MediaRange.constant("application", "x-x509-ca-cert");
const MediaRange APPLICATION_X_XFIG = const MediaRange.constant("application", "x-xfig");
const MediaRange APPLICATION_X_XLIFF_XML = const MediaRange.constant("application", "x-xliff+xml");
const MediaRange APPLICATION_X_XPINSTALL = const MediaRange.constant("application", "x-xpinstall");
const MediaRange APPLICATION_X_XZ = const MediaRange.constant("application", "x-xz");
const MediaRange APPLICATION_X_ZMACHINE = const MediaRange.constant("application", "x-zmachine");
const MediaRange APPLICATION_YANG = const MediaRange.constant("application", "yang");
const MediaRange APPLICATION_YIN_XML = const MediaRange.constant("application", "yin+xml");
const MediaRange APPLICATION_ZIP = const MediaRange.constant("application", "zip");
const MediaRange AUDIO_ADPCM = const MediaRange.constant("audio", "adpcm");
const MediaRange AUDIO_BASIC = const MediaRange.constant("audio", "basic");
const MediaRange AUDIO_MIDI = const MediaRange.constant("audio", "midi");
const MediaRange AUDIO_MP4 = const MediaRange.constant("audio", "mp4");
const MediaRange AUDIO_MPEG = const MediaRange.constant("audio", "mpeg");
const MediaRange AUDIO_OGG = const MediaRange.constant("audio", "ogg");
const MediaRange AUDIO_S3M = const MediaRange.constant("audio", "s3m");
const MediaRange AUDIO_SILK = const MediaRange.constant("audio", "silk");
const MediaRange AUDIO_VND_DECE_AUDIO = const MediaRange.constant("audio", "vnd.dece.audio");
const MediaRange AUDIO_VND_DIGITAL_WINDS = const MediaRange.constant("audio", "vnd.digital-winds");
const MediaRange AUDIO_VND_DRA = const MediaRange.constant("audio", "vnd.dra");
const MediaRange AUDIO_VND_DTS = const MediaRange.constant("audio", "vnd.dts");
const MediaRange AUDIO_VND_DTS_HD = const MediaRange.constant("audio", "vnd.dts.hd");
const MediaRange AUDIO_VND_LUCENT_VOICE = const MediaRange.constant("audio", "vnd.lucent.voice");
const MediaRange AUDIO_VND_MS_PLAYREADY_MEDIA_PYA = const MediaRange.constant("audio", "vnd.ms-playready.media.pya");
const MediaRange AUDIO_VND_NUERA_ECELP4800 = const MediaRange.constant("audio", "vnd.nuera.ecelp4800");
const MediaRange AUDIO_VND_NUERA_ECELP7470 = const MediaRange.constant("audio", "vnd.nuera.ecelp7470");
const MediaRange AUDIO_VND_NUERA_ECELP9600 = const MediaRange.constant("audio", "vnd.nuera.ecelp9600");
const MediaRange AUDIO_VND_RIP = const MediaRange.constant("audio", "vnd.rip");
const MediaRange AUDIO_WEBM = const MediaRange.constant("audio", "webm");
const MediaRange AUDIO_XM = const MediaRange.constant("audio", "xm");
const MediaRange AUDIO_X_AAC = const MediaRange.constant("audio", "x-aac");
const MediaRange AUDIO_X_AIFF = const MediaRange.constant("audio", "x-aiff");
const MediaRange AUDIO_X_CAF = const MediaRange.constant("audio", "x-caf");
const MediaRange AUDIO_X_FLAC = const MediaRange.constant("audio", "x-flac");
const MediaRange AUDIO_X_MATROSKA = const MediaRange.constant("audio", "x-matroska");
const MediaRange AUDIO_X_MPEGURL = const MediaRange.constant("audio", "x-mpegurl");
const MediaRange AUDIO_X_MS_WAX = const MediaRange.constant("audio", "x-ms-wax");
const MediaRange AUDIO_X_MS_WMA = const MediaRange.constant("audio", "x-ms-wma");
const MediaRange AUDIO_X_PN_REALAUDIO = const MediaRange.constant("audio", "x-pn-realaudio");
const MediaRange AUDIO_X_PN_REALAUDIO_PLUGIN = const MediaRange.constant("audio", "x-pn-realaudio-plugin");
const MediaRange AUDIO_X_WAV = const MediaRange.constant("audio", "x-wav");
const MediaRange CHEMICAL_X_CDX = const MediaRange.constant("chemical", "x-cdx");
const MediaRange CHEMICAL_X_CIF = const MediaRange.constant("chemical", "x-cif");
const MediaRange CHEMICAL_X_CMDF = const MediaRange.constant("chemical", "x-cmdf");
const MediaRange CHEMICAL_X_CML = const MediaRange.constant("chemical", "x-cml");
const MediaRange CHEMICAL_X_CSML = const MediaRange.constant("chemical", "x-csml");
const MediaRange CHEMICAL_X_XYZ = const MediaRange.constant("chemical", "x-xyz");
const MediaRange IMAGE_BMP = const MediaRange.constant("image", "bmp");
const MediaRange IMAGE_CGM = const MediaRange.constant("image", "cgm");
const MediaRange IMAGE_G3FAX = const MediaRange.constant("image", "g3fax");
const MediaRange IMAGE_GIF = const MediaRange.constant("image", "gif");
const MediaRange IMAGE_IEF = const MediaRange.constant("image", "ief");
const MediaRange IMAGE_JPEG = const MediaRange.constant("image", "jpeg");
const MediaRange IMAGE_KTX = const MediaRange.constant("image", "ktx");
const MediaRange IMAGE_PNG = const MediaRange.constant("image", "png");
const MediaRange IMAGE_PRS_BTIF = const MediaRange.constant("image", "prs.btif");
const MediaRange IMAGE_SGI = const MediaRange.constant("image", "sgi");
const MediaRange IMAGE_SVG_XML = const MediaRange.constant("image", "svg+xml");
const MediaRange IMAGE_TIFF = const MediaRange.constant("image", "tiff");
const MediaRange IMAGE_VND_ADOBE_PHOTOSHOP = const MediaRange.constant("image", "vnd.adobe.photoshop");
const MediaRange IMAGE_VND_DECE_GRAPHIC = const MediaRange.constant("image", "vnd.dece.graphic");
const MediaRange IMAGE_VND_DJVU = const MediaRange.constant("image", "vnd.djvu");
const MediaRange IMAGE_VND_DWG = const MediaRange.constant("image", "vnd.dwg");
const MediaRange IMAGE_VND_DXF = const MediaRange.constant("image", "vnd.dxf");
const MediaRange IMAGE_VND_FASTBIDSHEET = const MediaRange.constant("image", "vnd.fastbidsheet");
const MediaRange IMAGE_VND_FPX = const MediaRange.constant("image", "vnd.fpx");
const MediaRange IMAGE_VND_FST = const MediaRange.constant("image", "vnd.fst");
const MediaRange IMAGE_VND_FUJIXEROX_EDMICS_MMR = const MediaRange.constant("image", "vnd.fujixerox.edmics-mmr");
const MediaRange IMAGE_VND_FUJIXEROX_EDMICS_RLC = const MediaRange.constant("image", "vnd.fujixerox.edmics-rlc");
const MediaRange IMAGE_VND_MS_MODI = const MediaRange.constant("image", "vnd.ms-modi");
const MediaRange IMAGE_VND_MS_PHOTO = const MediaRange.constant("image", "vnd.ms-photo");
const MediaRange IMAGE_VND_NET_FPX = const MediaRange.constant("image", "vnd.net-fpx");
const MediaRange IMAGE_VND_WAP_WBMP = const MediaRange.constant("image", "vnd.wap.wbmp");
const MediaRange IMAGE_VND_XIFF = const MediaRange.constant("image", "vnd.xiff");
const MediaRange IMAGE_WEBP = const MediaRange.constant("image", "webp");
const MediaRange IMAGE_X_3DS = const MediaRange.constant("image", "x-3ds");
const MediaRange IMAGE_X_CMU_RASTER = const MediaRange.constant("image", "x-cmu-raster");
const MediaRange IMAGE_X_CMX = const MediaRange.constant("image", "x-cmx");
const MediaRange IMAGE_X_FREEHAND = const MediaRange.constant("image", "x-freehand");
const MediaRange IMAGE_X_ICON = const MediaRange.constant("image", "x-icon");
const MediaRange IMAGE_X_MRSID_IMAGE = const MediaRange.constant("image", "x-mrsid-image");
const MediaRange IMAGE_X_PCX = const MediaRange.constant("image", "x-pcx");
const MediaRange IMAGE_X_PICT = const MediaRange.constant("image", "x-pict");
const MediaRange IMAGE_X_PORTABLE_ANYMAP = const MediaRange.constant("image", "x-portable-anymap");
const MediaRange IMAGE_X_PORTABLE_BITMAP = const MediaRange.constant("image", "x-portable-bitmap");
const MediaRange IMAGE_X_PORTABLE_GRAYMAP = const MediaRange.constant("image", "x-portable-graymap");
const MediaRange IMAGE_X_PORTABLE_PIXMAP = const MediaRange.constant("image", "x-portable-pixmap");
const MediaRange IMAGE_X_RGB = const MediaRange.constant("image", "x-rgb");
const MediaRange IMAGE_X_TGA = const MediaRange.constant("image", "x-tga");
const MediaRange IMAGE_X_XBITMAP = const MediaRange.constant("image", "x-xbitmap");
const MediaRange IMAGE_X_XPIXMAP = const MediaRange.constant("image", "x-xpixmap");
const MediaRange IMAGE_X_XWINDOWDUMP = const MediaRange.constant("image", "x-xwindowdump");
const MediaRange MESSAGE_RFC822 = const MediaRange.constant("message", "rfc822");
const MediaRange MODEL_IGES = const MediaRange.constant("model", "iges");
const MediaRange MODEL_MESH = const MediaRange.constant("model", "mesh");
const MediaRange MODEL_VND_COLLADA_XML = const MediaRange.constant("model", "vnd.collada+xml");
const MediaRange MODEL_VND_DWF = const MediaRange.constant("model", "vnd.dwf");
const MediaRange MODEL_VND_GDL = const MediaRange.constant("model", "vnd.gdl");
const MediaRange MODEL_VND_GTW = const MediaRange.constant("model", "vnd.gtw");
const MediaRange MODEL_VND_MTS = const MediaRange.constant("model", "vnd.mts");
const MediaRange MODEL_VND_VTU = const MediaRange.constant("model", "vnd.vtu");
const MediaRange MODEL_VRML = const MediaRange.constant("model", "vrml");
const MediaRange MODEL_X3D_BINARY = const MediaRange.constant("model", "x3d+binary");
const MediaRange MODEL_X3D_VRML = const MediaRange.constant("model", "x3d+vrml");
const MediaRange MODEL_X3D_XML = const MediaRange.constant("model", "x3d+xml");
const MediaRange MULTIPART_BYTE_RANGE = const MediaRange.constant("multipart", "byteranges");
const MediaRange MULTIPART_FORM_DATA = const MediaRange.constant("multipart", "form-data");
const MediaRange MULTIPART_RELATED = const MediaRange.constant("multipart" , "related");
const MediaRange TEXT_CACHE_MANIFEST = const MediaRange.constant("text", "cache-manifest");
const MediaRange TEXT_CALENDAR = const MediaRange.constant("text", "calendar");
const MediaRange TEXT_CSS = const MediaRange.constant("text", "css");
const MediaRange TEXT_CSV = const MediaRange.constant("text", "csv");
const MediaRange TEXT_HTML = const MediaRange.constant("text", "html");
const MediaRange TEXT_N3 = const MediaRange.constant("text", "n3");
const MediaRange TEXT_PLAIN = const MediaRange.constant("text", "plain");
const MediaRange TEXT_PRS_LINES_TAG = const MediaRange.constant("text", "prs.lines.tag");
const MediaRange TEXT_RICHTEXT = const MediaRange.constant("text", "richtext");
const MediaRange TEXT_SGML = const MediaRange.constant("text", "sgml");
const MediaRange TEXT_TAB_SEPARATED_VALUES = const MediaRange.constant("text", "tab-separated-values");
const MediaRange TEXT_TROFF = const MediaRange.constant("text", "troff");
const MediaRange TEXT_TURTLE = const MediaRange.constant("text", "turtle");
const MediaRange TEXT_URI_LIST = const MediaRange.constant("text", "uri-list");
const MediaRange TEXT_VCARD = const MediaRange.constant("text", "vcard");
const MediaRange TEXT_VND_CURL = const MediaRange.constant("text", "vnd.curl");
const MediaRange TEXT_VND_CURL_DCURL = const MediaRange.constant("text", "vnd.curl.dcurl");
const MediaRange TEXT_VND_CURL_MCURL = const MediaRange.constant("text", "vnd.curl.mcurl");
const MediaRange TEXT_VND_CURL_SCURL = const MediaRange.constant("text", "vnd.curl.scurl");
const MediaRange TEXT_VND_DVB_SUBTITLE = const MediaRange.constant("text", "vnd.dvb.subtitle");
const MediaRange TEXT_VND_FLY = const MediaRange.constant("text", "vnd.fly");
const MediaRange TEXT_VND_FMI_FLEXSTOR = const MediaRange.constant("text", "vnd.fmi.flexstor");
const MediaRange TEXT_VND_GRAPHVIZ = const MediaRange.constant("text", "vnd.graphviz");
const MediaRange TEXT_VND_IN3D_3DML = const MediaRange.constant("text", "vnd.in3d.3dml");
const MediaRange TEXT_VND_IN3D_SPOT = const MediaRange.constant("text", "vnd.in3d.spot");
const MediaRange TEXT_VND_SUN_J2ME_APP_DESCRIPTOR = const MediaRange.constant("text", "vnd.sun.j2me.app-descriptor");
const MediaRange TEXT_VND_WAP_WML = const MediaRange.constant("text", "vnd.wap.wml");
const MediaRange TEXT_VND_WAP_WMLSCRIPT = const MediaRange.constant("text", "vnd.wap.wmlscript");
const MediaRange TEXT_X_ASM = const MediaRange.constant("text", "x-asm");
const MediaRange TEXT_X_C = const MediaRange.constant("text", "x-c");
const MediaRange TEXT_X_FORTRAN = const MediaRange.constant("text", "x-fortran");
const MediaRange TEXT_X_JAVA_SOURCE = const MediaRange.constant("text", "x-java-source");
const MediaRange TEXT_X_NFO = const MediaRange.constant("text", "x-nfo");
const MediaRange TEXT_X_OPML = const MediaRange.constant("text", "x-opml");
const MediaRange TEXT_X_PASCAL = const MediaRange.constant("text", "x-pascal");
const MediaRange TEXT_X_SETEXT = const MediaRange.constant("text", "x-setext");
const MediaRange TEXT_X_SFV = const MediaRange.constant("text", "x-sfv");
const MediaRange TEXT_X_UUENCODE = const MediaRange.constant("text", "x-uuencode");
const MediaRange TEXT_X_VCALENDAR = const MediaRange.constant("text", "x-vcalendar");
const MediaRange TEXT_X_VCARD = const MediaRange.constant("text", "x-vcard");
const MediaRange VIDEO_3GPP = const MediaRange.constant("video", "3gpp");
const MediaRange VIDEO_3GPP2 = const MediaRange.constant("video", "3gpp2");
const MediaRange VIDEO_H261 = const MediaRange.constant("video", "h261");
const MediaRange VIDEO_H263 = const MediaRange.constant("video", "h263");
const MediaRange VIDEO_H264 = const MediaRange.constant("video", "h264");
const MediaRange VIDEO_JPEG = const MediaRange.constant("video", "jpeg");
const MediaRange VIDEO_JPM = const MediaRange.constant("video", "jpm");
const MediaRange VIDEO_MJ2 = const MediaRange.constant("video", "mj2");
const MediaRange VIDEO_MP4 = const MediaRange.constant("video", "mp4");
const MediaRange VIDEO_MPEG = const MediaRange.constant("video", "mpeg");
const MediaRange VIDEO_OGG = const MediaRange.constant("video", "ogg");
const MediaRange VIDEO_QUICKTIME = const MediaRange.constant("video", "quicktime");
const MediaRange VIDEO_VND_DECE_HD = const MediaRange.constant("video", "vnd.dece.hd");
const MediaRange VIDEO_VND_DECE_MOBILE = const MediaRange.constant("video", "vnd.dece.mobile");
const MediaRange VIDEO_VND_DECE_PD = const MediaRange.constant("video", "vnd.dece.pd");
const MediaRange VIDEO_VND_DECE_SD = const MediaRange.constant("video", "vnd.dece.sd");
const MediaRange VIDEO_VND_DECE_VIDEO = const MediaRange.constant("video", "vnd.dece.video");
const MediaRange VIDEO_VND_DVB_FILE = const MediaRange.constant("video", "vnd.dvb.file");
const MediaRange VIDEO_VND_FVT = const MediaRange.constant("video", "vnd.fvt");
const MediaRange VIDEO_VND_MPEGURL = const MediaRange.constant("video", "vnd.mpegurl");
const MediaRange VIDEO_VND_MS_PLAYREADY_MEDIA_PYV = const MediaRange.constant("video", "vnd.ms-playready.media.pyv");
const MediaRange VIDEO_VND_UVVU_MP4 = const MediaRange.constant("video", "vnd.uvvu.mp4");
const MediaRange VIDEO_VND_VIVO = const MediaRange.constant("video", "vnd.vivo");
const MediaRange VIDEO_WEBM = const MediaRange.constant("video", "webm");
const MediaRange VIDEO_X_F4V = const MediaRange.constant("video", "x-f4v");
const MediaRange VIDEO_X_FLI = const MediaRange.constant("video", "x-fli");
const MediaRange VIDEO_X_FLV = const MediaRange.constant("video", "x-flv");
const MediaRange VIDEO_X_M4V = const MediaRange.constant("video", "x-m4v");
const MediaRange VIDEO_X_MATROSKA = const MediaRange.constant("video", "x-matroska");
const MediaRange VIDEO_X_MNG = const MediaRange.constant("video", "x-mng");
const MediaRange VIDEO_X_MSVIDEO = const MediaRange.constant("video", "x-msvideo");
const MediaRange VIDEO_X_MS_ASF = const MediaRange.constant("video", "x-ms-asf");
const MediaRange VIDEO_X_MS_VOB = const MediaRange.constant("video", "x-ms-vob");
const MediaRange VIDEO_X_MS_WM = const MediaRange.constant("video", "x-ms-wm");
const MediaRange VIDEO_X_MS_WMV = const MediaRange.constant("video", "x-ms-wmv");
const MediaRange VIDEO_X_MS_WMX = const MediaRange.constant("video", "x-ms-wmx");
const MediaRange VIDEO_X_MS_WVX = const MediaRange.constant("video", "x-ms-wvx");
const MediaRange VIDEO_X_SGI_MOVIE = const MediaRange.constant("video", "x-sgi-movie");
const MediaRange VIDEO_X_SMV = const MediaRange.constant("video", "x-smv");
const MediaRange X_CONFERENCE_X_COOLTALK = const MediaRange.constant("x-conference", "x-cooltalk");

const Map<String, MediaRange> _DEFAUlT_EXTENSION_MAP = const <String, MediaRange>{
"123" : APPLICATION_VND_LOTUS_1_2_3,
"3dml" : TEXT_VND_IN3D_3DML,
"3ds" : IMAGE_X_3DS,
"3g2" : VIDEO_3GPP2,
"3gp" : VIDEO_3GPP,
"7z" : APPLICATION_X_7Z_COMPRESSED,
"aab" : APPLICATION_X_AUTHORWARE_BIN,
"aac" : AUDIO_X_AAC,
"aam" : APPLICATION_X_AUTHORWARE_MAP,
"aas" : APPLICATION_X_AUTHORWARE_SEG,
"abw" : APPLICATION_X_ABIWORD,
"ac" : APPLICATION_PKIX_ATTR_CERT,
"acc" : APPLICATION_VND_AMERICANDYNAMICS_ACC,
"ace" : APPLICATION_X_ACE_COMPRESSED,
"acu" : APPLICATION_VND_ACUCOBOL,
"acutc" : APPLICATION_VND_ACUCORP,
"adp" : AUDIO_ADPCM,
"aep" : APPLICATION_VND_AUDIOGRAPH,
"afm" : APPLICATION_X_FONT_TYPE1,
"afp" : APPLICATION_VND_IBM_MODCAP,
"ahead" : APPLICATION_VND_AHEAD_SPACE,
"ai" : APPLICATION_POSTSCRIPT,
"aif" : AUDIO_X_AIFF,
"aifc" : AUDIO_X_AIFF,
"aiff" : AUDIO_X_AIFF,
"air" : APPLICATION_VND_ADOBE_AIR_APPLICATION_INSTALLER_PACKAGE_ZIP,
"ait" : APPLICATION_VND_DVB_AIT,
"ami" : APPLICATION_VND_AMIGA_AMI,
"apk" : APPLICATION_VND_ANDROID_PACKAGE_ARCHIVE,
"appcache" : TEXT_CACHE_MANIFEST,
"application" : APPLICATION_X_MS_APPLICATION,
"apr" : APPLICATION_VND_LOTUS_APPROACH,
"arc" : APPLICATION_X_FREEARC,
"asc" : APPLICATION_PGP_SIGNATURE,
"asf" : VIDEO_X_MS_ASF,
"asm" : TEXT_X_ASM,
"aso" : APPLICATION_VND_ACCPAC_SIMPLY_ASO,
"asx" : VIDEO_X_MS_ASF,
"atc" : APPLICATION_VND_ACUCORP,
"atom" : APPLICATION_ATOM_XML,
"atomcat" : APPLICATION_ATOMCAT_XML,
"atomsvc" : APPLICATION_ATOMSVC_XML,
"atx" : APPLICATION_VND_ANTIX_GAME_COMPONENT,
"au" : AUDIO_BASIC,
"avi" : VIDEO_X_MSVIDEO,
"aw" : APPLICATION_APPLIXWARE,
"azf" : APPLICATION_VND_AIRZIP_FILESECURE_AZF,
"azs" : APPLICATION_VND_AIRZIP_FILESECURE_AZS,
"azw" : APPLICATION_VND_AMAZON_EBOOK,
"bat" : APPLICATION_X_MSDOWNLOAD,
"bcpio" : APPLICATION_X_BCPIO,
"bdf" : APPLICATION_X_FONT_BDF,
"bdm" : APPLICATION_VND_SYNCML_DM_WBXML,
"bed" : APPLICATION_VND_REALVNC_BED,
"bh2" : APPLICATION_VND_FUJITSU_OASYSPRS,
"bin" : APPLICATION_OCTET_STREAM,
"blb" : APPLICATION_X_BLORB,
"blorb" : APPLICATION_X_BLORB,
"bmi" : APPLICATION_VND_BMI,
"bmp" : IMAGE_BMP,
"book" : APPLICATION_VND_FRAMEMAKER,
"box" : APPLICATION_VND_PREVIEWSYSTEMS_BOX,
"boz" : APPLICATION_X_BZIP2,
"bpk" : APPLICATION_OCTET_STREAM,
"btif" : IMAGE_PRS_BTIF,
"bz" : APPLICATION_X_BZIP,
"bz2" : APPLICATION_X_BZIP2,
"c" : TEXT_X_C,
"c11amc" : APPLICATION_VND_CLUETRUST_CARTOMOBILE_CONFIG,
"c11amz" : APPLICATION_VND_CLUETRUST_CARTOMOBILE_CONFIG_PKG,
"c4d" : APPLICATION_VND_CLONK_C4GROUP,
"c4f" : APPLICATION_VND_CLONK_C4GROUP,
"c4g" : APPLICATION_VND_CLONK_C4GROUP,
"c4p" : APPLICATION_VND_CLONK_C4GROUP,
"c4u" : APPLICATION_VND_CLONK_C4GROUP,
"cab" : APPLICATION_VND_MS_CAB_COMPRESSED,
"caf" : AUDIO_X_CAF,
"cap" : APPLICATION_VND_TCPDUMP_PCAP,
"car" : APPLICATION_VND_CURL_CAR,
"cat" : APPLICATION_VND_MS_PKI_SECCAT,
"cb7" : APPLICATION_X_CBR,
"cba" : APPLICATION_X_CBR,
"cbr" : APPLICATION_X_CBR,
"cbt" : APPLICATION_X_CBR,
"cbz" : APPLICATION_X_CBR,
"cc" : TEXT_X_C,
"cct" : APPLICATION_X_DIRECTOR,
"ccxml" : APPLICATION_CCXML_XML,
"cdbcmsg" : APPLICATION_VND_CONTACT_CMSG,
"cdf" : APPLICATION_X_NETCDF,
"cdkey" : APPLICATION_VND_MEDIASTATION_CDKEY,
"cdmia" : APPLICATION_CDMI_CAPABILITY,
"cdmic" : APPLICATION_CDMI_CONTAINER,
"cdmid" : APPLICATION_CDMI_DOMAIN,
"cdmio" : APPLICATION_CDMI_OBJECT,
"cdmiq" : APPLICATION_CDMI_QUEUE,
"cdx" : CHEMICAL_X_CDX,
"cdxml" : APPLICATION_VND_CHEMDRAW_XML,
"cdy" : APPLICATION_VND_CINDERELLA,
"cer" : APPLICATION_PKIX_CERT,
"cfs" : APPLICATION_X_CFS_COMPRESSED,
"cgm" : IMAGE_CGM,
"chat" : APPLICATION_X_CHAT,
"chm" : APPLICATION_VND_MS_HTMLHELP,
"chrt" : APPLICATION_VND_KDE_KCHART,
"cif" : CHEMICAL_X_CIF,
"cii" : APPLICATION_VND_ANSER_WEB_CERTIFICATE_ISSUE_INITIATION,
"cil" : APPLICATION_VND_MS_ARTGALRY,
"cla" : APPLICATION_VND_CLAYMORE,
"class" : APPLICATION_JAVA_VM,
"clkk" : APPLICATION_VND_CRICK_CLICKER_KEYBOARD,
"clkp" : APPLICATION_VND_CRICK_CLICKER_PALETTE,
"clkt" : APPLICATION_VND_CRICK_CLICKER_TEMPLATE,
"clkw" : APPLICATION_VND_CRICK_CLICKER_WORDBANK,
"clkx" : APPLICATION_VND_CRICK_CLICKER,
"clp" : APPLICATION_X_MSCLIP,
"cmc" : APPLICATION_VND_COSMOCALLER,
"cmdf" : CHEMICAL_X_CMDF,
"cml" : CHEMICAL_X_CML,
"cmp" : APPLICATION_VND_YELLOWRIVER_CUSTOM_MENU,
"cmx" : IMAGE_X_CMX,
"cod" : APPLICATION_VND_RIM_COD,
"com" : APPLICATION_X_MSDOWNLOAD,
"conf" : TEXT_PLAIN,
"cpio" : APPLICATION_X_CPIO,
"cpp" : TEXT_X_C,
"cpt" : APPLICATION_MAC_COMPACTPRO,
"crd" : APPLICATION_X_MSCARDFILE,
"crl" : APPLICATION_PKIX_CRL,
"crt" : APPLICATION_X_X509_CA_CERT,
"cryptonote" : APPLICATION_VND_RIG_CRYPTONOTE,
"csh" : APPLICATION_X_CSH,
"csml" : CHEMICAL_X_CSML,
"csp" : APPLICATION_VND_COMMONSPACE,
"css" : TEXT_CSS,
"cst" : APPLICATION_X_DIRECTOR,
"csv" : TEXT_CSV,
"cu" : APPLICATION_CU_SEEME,
"curl" : TEXT_VND_CURL,
"cww" : APPLICATION_PRS_CWW,
"cxt" : APPLICATION_X_DIRECTOR,
"cxx" : TEXT_X_C,
"dae" : MODEL_VND_COLLADA_XML,
"daf" : APPLICATION_VND_MOBIUS_DAF,
"dart" : APPLICATION_DART,
"dataless" : APPLICATION_VND_FDSN_SEED,
"davmount" : APPLICATION_DAVMOUNT_XML,
"dbk" : APPLICATION_DOCBOOK_XML,
"dcr" : APPLICATION_X_DIRECTOR,
"dcurl" : TEXT_VND_CURL_DCURL,
"dd2" : APPLICATION_VND_OMA_DD2_XML,
"ddd" : APPLICATION_VND_FUJIXEROX_DDD,
"deb" : APPLICATION_X_DEBIAN_PACKAGE,
"def" : TEXT_PLAIN,
"deploy" : APPLICATION_OCTET_STREAM,
"der" : APPLICATION_X_X509_CA_CERT,
"dfac" : APPLICATION_VND_DREAMFACTORY,
"dgc" : APPLICATION_X_DGC_COMPRESSED,
"dic" : TEXT_X_C,
"dir" : APPLICATION_X_DIRECTOR,
"dis" : APPLICATION_VND_MOBIUS_DIS,
"dist" : APPLICATION_OCTET_STREAM,
"distz" : APPLICATION_OCTET_STREAM,
"djv" : IMAGE_VND_DJVU,
"djvu" : IMAGE_VND_DJVU,
"dll" : APPLICATION_X_MSDOWNLOAD,
"dmg" : APPLICATION_X_APPLE_DISKIMAGE,
"dmp" : APPLICATION_VND_TCPDUMP_PCAP,
"dms" : APPLICATION_OCTET_STREAM,
"dna" : APPLICATION_VND_DNA,
"doc" : APPLICATION_MSWORD,
"docm" : APPLICATION_VND_MS_WORD_DOCUMENT_MACROENABLED_12,
"docx" : APPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_WORDPROCESSINGML_DOCUMENT,
"dot" : APPLICATION_MSWORD,
"dotm" : APPLICATION_VND_MS_WORD_TEMPLATE_MACROENABLED_12,
"dotx" : APPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_WORDPROCESSINGML_TEMPLATE,
"dp" : APPLICATION_VND_OSGI_DP,
"dpg" : APPLICATION_VND_DPGRAPH,
"dra" : AUDIO_VND_DRA,
"dsc" : TEXT_PRS_LINES_TAG,
"dssc" : APPLICATION_DSSC_DER,
"dtb" : APPLICATION_X_DTBOOK_XML,
"dtd" : APPLICATION_XML_DTD,
"dts" : AUDIO_VND_DTS,
"dtshd" : AUDIO_VND_DTS_HD,
"dump" : APPLICATION_OCTET_STREAM,
"dvb" : VIDEO_VND_DVB_FILE,
"dvi" : APPLICATION_X_DVI,
"dwf" : MODEL_VND_DWF,
"dwg" : IMAGE_VND_DWG,
"dxf" : IMAGE_VND_DXF,
"dxp" : APPLICATION_VND_SPOTFIRE_DXP,
"dxr" : APPLICATION_X_DIRECTOR,
"ecelp4800" : AUDIO_VND_NUERA_ECELP4800,
"ecelp7470" : AUDIO_VND_NUERA_ECELP7470,
"ecelp9600" : AUDIO_VND_NUERA_ECELP9600,
"ecma" : APPLICATION_ECMASCRIPT,
"edm" : APPLICATION_VND_NOVADIGM_EDM,
"edx" : APPLICATION_VND_NOVADIGM_EDX,
"efif" : APPLICATION_VND_PICSEL,
"ei6" : APPLICATION_VND_PG_OSASLI,
"elc" : APPLICATION_OCTET_STREAM,
"emf" : APPLICATION_X_MSMETAFILE,
"eml" : MESSAGE_RFC822,
"emma" : APPLICATION_EMMA_XML,
"emz" : APPLICATION_X_MSMETAFILE,
"eol" : AUDIO_VND_DIGITAL_WINDS,
"eot" : APPLICATION_VND_MS_FONTOBJECT,
"eps" : APPLICATION_POSTSCRIPT,
"epub" : APPLICATION_EPUB_ZIP,
"es3" : APPLICATION_VND_ESZIGNO3_XML,
"esa" : APPLICATION_VND_OSGI_SUBSYSTEM,
"esf" : APPLICATION_VND_EPSON_ESF,
"et3" : APPLICATION_VND_ESZIGNO3_XML,
"etx" : TEXT_X_SETEXT,
"eva" : APPLICATION_X_EVA,
"evy" : APPLICATION_X_ENVOY,
"exe" : APPLICATION_X_MSDOWNLOAD,
"exi" : APPLICATION_EXI,
"ext" : APPLICATION_VND_NOVADIGM_EXT,
"ez" : APPLICATION_ANDREW_INSET,
"ez2" : APPLICATION_VND_EZPIX_ALBUM,
"ez3" : APPLICATION_VND_EZPIX_PACKAGE,
"f" : TEXT_X_FORTRAN,
"f4v" : VIDEO_X_F4V,
"f77" : TEXT_X_FORTRAN,
"f90" : TEXT_X_FORTRAN,
"fbs" : IMAGE_VND_FASTBIDSHEET,
"fcdt" : APPLICATION_VND_ADOBE_FORMSCENTRAL_FCDT,
"fcs" : APPLICATION_VND_ISAC_FCS,
"fdf" : APPLICATION_VND_FDF,
"fe_launch" : APPLICATION_VND_DENOVO_FCSELAYOUT_LINK,
"fg5" : APPLICATION_VND_FUJITSU_OASYSGP,
"fgd" : APPLICATION_X_DIRECTOR,
"fh" : IMAGE_X_FREEHAND,
"fh4" : IMAGE_X_FREEHAND,
"fh5" : IMAGE_X_FREEHAND,
"fh7" : IMAGE_X_FREEHAND,
"fhc" : IMAGE_X_FREEHAND,
"fig" : APPLICATION_X_XFIG,
"flac" : AUDIO_X_FLAC,
"fli" : VIDEO_X_FLI,
"flo" : APPLICATION_VND_MICROGRAFX_FLO,
"flv" : VIDEO_X_FLV,
"flw" : APPLICATION_VND_KDE_KIVIO,
"flx" : TEXT_VND_FMI_FLEXSTOR,
"fly" : TEXT_VND_FLY,
"fm" : APPLICATION_VND_FRAMEMAKER,
"fnc" : APPLICATION_VND_FROGANS_FNC,
"for" : TEXT_X_FORTRAN,
"fpx" : IMAGE_VND_FPX,
"frame" : APPLICATION_VND_FRAMEMAKER,
"fsc" : APPLICATION_VND_FSC_WEBLAUNCH,
"fst" : IMAGE_VND_FST,
"ftc" : APPLICATION_VND_FLUXTIME_CLIP,
"fti" : APPLICATION_VND_ANSER_WEB_FUNDS_TRANSFER_INITIATION,
"fvt" : VIDEO_VND_FVT,
"fxp" : APPLICATION_VND_ADOBE_FXP,
"fxpl" : APPLICATION_VND_ADOBE_FXP,
"fzs" : APPLICATION_VND_FUZZYSHEET,
"g2w" : APPLICATION_VND_GEOPLAN,
"g3" : IMAGE_G3FAX,
"g3w" : APPLICATION_VND_GEOSPACE,
"gac" : APPLICATION_VND_GROOVE_ACCOUNT,
"gam" : APPLICATION_X_TADS,
"gbr" : APPLICATION_RPKI_GHOSTBUSTERS,
"gca" : APPLICATION_X_GCA_COMPRESSED,
"gdl" : MODEL_VND_GDL,
"geo" : APPLICATION_VND_DYNAGEO,
"gex" : APPLICATION_VND_GEOMETRY_EXPLORER,
"ggb" : APPLICATION_VND_GEOGEBRA_FILE,
"ggt" : APPLICATION_VND_GEOGEBRA_TOOL,
"ghf" : APPLICATION_VND_GROOVE_HELP,
"gif" : IMAGE_GIF,
"gim" : APPLICATION_VND_GROOVE_IDENTITY_MESSAGE,
"gml" : APPLICATION_GML_XML,
"gmx" : APPLICATION_VND_GMX,
"gnumeric" : APPLICATION_X_GNUMERIC,
"gph" : APPLICATION_VND_FLOGRAPHIT,
"gpx" : APPLICATION_GPX_XML,
"gqf" : APPLICATION_VND_GRAFEQ,
"gqs" : APPLICATION_VND_GRAFEQ,
"gram" : APPLICATION_SRGS,
"gramps" : APPLICATION_X_GRAMPS_XML,
"gre" : APPLICATION_VND_GEOMETRY_EXPLORER,
"grv" : APPLICATION_VND_GROOVE_INJECTOR,
"grxml" : APPLICATION_SRGS_XML,
"gsf" : APPLICATION_X_FONT_GHOSTSCRIPT,
"gtar" : APPLICATION_X_GTAR,
"gtm" : APPLICATION_VND_GROOVE_TOOL_MESSAGE,
"gtw" : MODEL_VND_GTW,
"gv" : TEXT_VND_GRAPHVIZ,
"gxf" : APPLICATION_GXF,
"gxt" : APPLICATION_VND_GEONEXT,
"h" : TEXT_X_C,
"h261" : VIDEO_H261,
"h263" : VIDEO_H263,
"h264" : VIDEO_H264,
"hal" : APPLICATION_VND_HAL_XML,
"hbci" : APPLICATION_VND_HBCI,
"hdf" : APPLICATION_X_HDF,
"hh" : TEXT_X_C,
"hlp" : APPLICATION_WINHLP,
"hpgl" : APPLICATION_VND_HP_HPGL,
"hpid" : APPLICATION_VND_HP_HPID,
"hps" : APPLICATION_VND_HP_HPS,
"hqx" : APPLICATION_MAC_BINHEX40,
"htke" : APPLICATION_VND_KENAMEAAPP,
"htm" : TEXT_HTML,
"html" : TEXT_HTML,
"hvd" : APPLICATION_VND_YAMAHA_HV_DIC,
"hvp" : APPLICATION_VND_YAMAHA_HV_VOICE,
"hvs" : APPLICATION_VND_YAMAHA_HV_SCRIPT,
"i2g" : APPLICATION_VND_INTERGEO,
"icc" : APPLICATION_VND_ICCPROFILE,
"ice" : X_CONFERENCE_X_COOLTALK,
"icm" : APPLICATION_VND_ICCPROFILE,
"ico" : IMAGE_X_ICON,
"ics" : TEXT_CALENDAR,
"ief" : IMAGE_IEF,
"ifb" : TEXT_CALENDAR,
"ifm" : APPLICATION_VND_SHANA_INFORMED_FORMDATA,
"iges" : MODEL_IGES,
"igl" : APPLICATION_VND_IGLOADER,
"igm" : APPLICATION_VND_INSORS_IGM,
"igs" : MODEL_IGES,
"igx" : APPLICATION_VND_MICROGRAFX_IGX,
"iif" : APPLICATION_VND_SHANA_INFORMED_INTERCHANGE,
"imp" : APPLICATION_VND_ACCPAC_SIMPLY_IMP,
"ims" : APPLICATION_VND_MS_IMS,
"in" : TEXT_PLAIN,
"ink" : APPLICATION_INKML_XML,
"inkml" : APPLICATION_INKML_XML,
"install" : APPLICATION_X_INSTALL_INSTRUCTIONS,
"iota" : APPLICATION_VND_ASTRAEA_SOFTWARE_IOTA,
"ipfix" : APPLICATION_IPFIX,
"ipk" : APPLICATION_VND_SHANA_INFORMED_PACKAGE,
"irm" : APPLICATION_VND_IBM_RIGHTS_MANAGEMENT,
"irp" : APPLICATION_VND_IREPOSITORY_PACKAGE_XML,
"iso" : APPLICATION_X_ISO9660_IMAGE,
"itp" : APPLICATION_VND_SHANA_INFORMED_FORMTEMPLATE,
"ivp" : APPLICATION_VND_IMMERVISION_IVP,
"ivu" : APPLICATION_VND_IMMERVISION_IVU,
"jad" : TEXT_VND_SUN_J2ME_APP_DESCRIPTOR,
"jam" : APPLICATION_VND_JAM,
"jar" : APPLICATION_JAVA_ARCHIVE,
"java" : TEXT_X_JAVA_SOURCE,
"jisp" : APPLICATION_VND_JISP,
"jlt" : APPLICATION_VND_HP_JLYT,
"jnlp" : APPLICATION_X_JAVA_JNLP_FILE,
"joda" : APPLICATION_VND_JOOST_JODA_ARCHIVE,
"jpe" : IMAGE_JPEG,
"jpeg" : IMAGE_JPEG,
"jpg" : IMAGE_JPEG,
"jpgm" : VIDEO_JPM,
"jpgv" : VIDEO_JPEG,
"jpm" : VIDEO_JPM,
"js" : APPLICATION_JAVASCRIPT,
"json" : APPLICATION_JSON,
"jsonml" : APPLICATION_JSONML_JSON,
"kar" : AUDIO_MIDI,
"karbon" : APPLICATION_VND_KDE_KARBON,
"kfo" : APPLICATION_VND_KDE_KFORMULA,
"kia" : APPLICATION_VND_KIDSPIRATION,
"kml" : APPLICATION_VND_GOOGLE_EARTH_KML_XML,
"kmz" : APPLICATION_VND_GOOGLE_EARTH_KMZ,
"kne" : APPLICATION_VND_KINAR,
"knp" : APPLICATION_VND_KINAR,
"kon" : APPLICATION_VND_KDE_KONTOUR,
"kpr" : APPLICATION_VND_KDE_KPRESENTER,
"kpt" : APPLICATION_VND_KDE_KPRESENTER,
"kpxx" : APPLICATION_VND_DS_KEYPOINT,
"ksp" : APPLICATION_VND_KDE_KSPREAD,
"ktr" : APPLICATION_VND_KAHOOTZ,
"ktx" : IMAGE_KTX,
"ktz" : APPLICATION_VND_KAHOOTZ,
"kwd" : APPLICATION_VND_KDE_KWORD,
"kwt" : APPLICATION_VND_KDE_KWORD,
"lasxml" : APPLICATION_VND_LAS_LAS_XML,
"latex" : APPLICATION_X_LATEX,
"lbd" : APPLICATION_VND_LLAMAGRAPHICS_LIFE_BALANCE_DESKTOP,
"lbe" : APPLICATION_VND_LLAMAGRAPHICS_LIFE_BALANCE_EXCHANGE_XML,
"les" : APPLICATION_VND_HHE_LESSON_PLAYER,
"lha" : APPLICATION_X_LZH_COMPRESSED,
"link66" : APPLICATION_VND_ROUTE66_LINK66_XML,
"list" : TEXT_PLAIN,
"list3820" : APPLICATION_VND_IBM_MODCAP,
"listafp" : APPLICATION_VND_IBM_MODCAP,
"lnk" : APPLICATION_X_MS_SHORTCUT,
"log" : TEXT_PLAIN,
"lostxml" : APPLICATION_LOST_XML,
"lrf" : APPLICATION_OCTET_STREAM,
"lrm" : APPLICATION_VND_MS_LRM,
"ltf" : APPLICATION_VND_FROGANS_LTF,
"lvp" : AUDIO_VND_LUCENT_VOICE,
"lwp" : APPLICATION_VND_LOTUS_WORDPRO,
"lzh" : APPLICATION_X_LZH_COMPRESSED,
"m13" : APPLICATION_X_MSMEDIAVIEW,
"m14" : APPLICATION_X_MSMEDIAVIEW,
"m1v" : VIDEO_MPEG,
"m21" : APPLICATION_MP21,
"m2a" : AUDIO_MPEG,
"m2v" : VIDEO_MPEG,
"m3a" : AUDIO_MPEG,
"m3u" : AUDIO_X_MPEGURL,
"m3u8" : APPLICATION_VND_APPLE_MPEGURL,
"m4u" : VIDEO_VND_MPEGURL,
"m4v" : VIDEO_X_M4V,
"ma" : APPLICATION_MATHEMATICA,
"mads" : APPLICATION_MADS_XML,
"mag" : APPLICATION_VND_ECOWIN_CHART,
"maker" : APPLICATION_VND_FRAMEMAKER,
"man" : TEXT_TROFF,
"mar" : APPLICATION_OCTET_STREAM,
"mathml" : APPLICATION_MATHML_XML,
"mb" : APPLICATION_MATHEMATICA,
"mbk" : APPLICATION_VND_MOBIUS_MBK,
"mbox" : APPLICATION_MBOX,
"mc1" : APPLICATION_VND_MEDCALCDATA,
"mcd" : APPLICATION_VND_MCD,
"mcurl" : TEXT_VND_CURL_MCURL,
"mdb" : APPLICATION_X_MSACCESS,
"mdi" : IMAGE_VND_MS_MODI,
"me" : TEXT_TROFF,
"mesh" : MODEL_MESH,
"meta4" : APPLICATION_METALINK4_XML,
"metalink" : APPLICATION_METALINK_XML,
"mets" : APPLICATION_METS_XML,
"mfm" : APPLICATION_VND_MFMP,
"mft" : APPLICATION_RPKI_MANIFEST,
"mgp" : APPLICATION_VND_OSGEO_MAPGUIDE_PACKAGE,
"mgz" : APPLICATION_VND_PROTEUS_MAGAZINE,
"mid" : AUDIO_MIDI,
"midi" : AUDIO_MIDI,
"mie" : APPLICATION_X_MIE,
"mif" : APPLICATION_VND_MIF,
"mime" : MESSAGE_RFC822,
"mj2" : VIDEO_MJ2,
"mjp2" : VIDEO_MJ2,
"mk3d" : VIDEO_X_MATROSKA,
"mka" : AUDIO_X_MATROSKA,
"mks" : VIDEO_X_MATROSKA,
"mkv" : VIDEO_X_MATROSKA,
"mlp" : APPLICATION_VND_DOLBY_MLP,
"mmd" : APPLICATION_VND_CHIPNUTS_KARAOKE_MMD,
"mmf" : APPLICATION_VND_SMAF,
"mmr" : IMAGE_VND_FUJIXEROX_EDMICS_MMR,
"mng" : VIDEO_X_MNG,
"mny" : APPLICATION_X_MSMONEY,
"mobi" : APPLICATION_X_MOBIPOCKET_EBOOK,
"mods" : APPLICATION_MODS_XML,
"mov" : VIDEO_QUICKTIME,
"movie" : VIDEO_X_SGI_MOVIE,
"mp2" : AUDIO_MPEG,
"mp21" : APPLICATION_MP21,
"mp2a" : AUDIO_MPEG,
"mp3" : AUDIO_MPEG,
"mp4" : VIDEO_MP4,
"mp4a" : AUDIO_MP4,
"mp4s" : APPLICATION_MP4,
"mp4v" : VIDEO_MP4,
"mpc" : APPLICATION_VND_MOPHUN_CERTIFICATE,
"mpe" : VIDEO_MPEG,
"mpeg" : VIDEO_MPEG,
"mpg" : VIDEO_MPEG,
"mpg4" : VIDEO_MP4,
"mpga" : AUDIO_MPEG,
"mpkg" : APPLICATION_VND_APPLE_INSTALLER_XML,
"mpm" : APPLICATION_VND_BLUEICE_MULTIPASS,
"mpn" : APPLICATION_VND_MOPHUN_APPLICATION,
"mpp" : APPLICATION_VND_MS_PROJECT,
"mpt" : APPLICATION_VND_MS_PROJECT,
"mpy" : APPLICATION_VND_IBM_MINIPAY,
"mqy" : APPLICATION_VND_MOBIUS_MQY,
"mrc" : APPLICATION_MARC,
"mrcx" : APPLICATION_MARCXML_XML,
"ms" : TEXT_TROFF,
"mscml" : APPLICATION_MEDIASERVERCONTROL_XML,
"mseed" : APPLICATION_VND_FDSN_MSEED,
"mseq" : APPLICATION_VND_MSEQ,
"msf" : APPLICATION_VND_EPSON_MSF,
"msh" : MODEL_MESH,
"msi" : APPLICATION_X_MSDOWNLOAD,
"msl" : APPLICATION_VND_MOBIUS_MSL,
"msty" : APPLICATION_VND_MUVEE_STYLE,
"mts" : MODEL_VND_MTS,
"mus" : APPLICATION_VND_MUSICIAN,
"musicxml" : APPLICATION_VND_RECORDARE_MUSICXML_XML,
"mvb" : APPLICATION_X_MSMEDIAVIEW,
"mwf" : APPLICATION_VND_MFER,
"mxf" : APPLICATION_MXF,
"mxl" : APPLICATION_VND_RECORDARE_MUSICXML,
"mxml" : APPLICATION_XV_XML,
"mxs" : APPLICATION_VND_TRISCAPE_MXS,
"mxu" : VIDEO_VND_MPEGURL,
"n-gage" : APPLICATION_VND_NOKIA_N_GAGE_SYMBIAN_INSTALL,
"n3" : TEXT_N3,
"nb" : APPLICATION_MATHEMATICA,
"nbp" : APPLICATION_VND_WOLFRAM_PLAYER,
"nc" : APPLICATION_X_NETCDF,
"ncx" : APPLICATION_X_DTBNCX_XML,
"nfo" : TEXT_X_NFO,
"ngdat" : APPLICATION_VND_NOKIA_N_GAGE_DATA,
"nitf" : APPLICATION_VND_NITF,
"nlu" : APPLICATION_VND_NEUROLANGUAGE_NLU,
"nml" : APPLICATION_VND_ENLIVEN,
"nnd" : APPLICATION_VND_NOBLENET_DIRECTORY,
"nns" : APPLICATION_VND_NOBLENET_SEALER,
"nnw" : APPLICATION_VND_NOBLENET_WEB,
"npx" : IMAGE_VND_NET_FPX,
"nsc" : APPLICATION_X_CONFERENCE,
"nsf" : APPLICATION_VND_LOTUS_NOTES,
"ntf" : APPLICATION_VND_NITF,
"nzb" : APPLICATION_X_NZB,
"oa2" : APPLICATION_VND_FUJITSU_OASYS2,
"oa3" : APPLICATION_VND_FUJITSU_OASYS3,
"oas" : APPLICATION_VND_FUJITSU_OASYS,
"obd" : APPLICATION_X_MSBINDER,
"obj" : APPLICATION_X_TGIF,
"oda" : APPLICATION_ODA,
"odb" : APPLICATION_VND_OASIS_OPENDOCUMENT_DATABASE,
"odc" : APPLICATION_VND_OASIS_OPENDOCUMENT_CHART,
"odf" : APPLICATION_VND_OASIS_OPENDOCUMENT_FORMULA,
"odft" : APPLICATION_VND_OASIS_OPENDOCUMENT_FORMULA_TEMPLATE,
"odg" : APPLICATION_VND_OASIS_OPENDOCUMENT_GRAPHICS,
"odi" : APPLICATION_VND_OASIS_OPENDOCUMENT_IMAGE,
"odm" : APPLICATION_VND_OASIS_OPENDOCUMENT_TEXT_MASTER,
"odp" : APPLICATION_VND_OASIS_OPENDOCUMENT_PRESENTATION,
"ods" : APPLICATION_VND_OASIS_OPENDOCUMENT_SPREADSHEET,
"odt" : APPLICATION_VND_OASIS_OPENDOCUMENT_TEXT,
"oga" : AUDIO_OGG,
"ogg" : AUDIO_OGG,
"ogv" : VIDEO_OGG,
"ogx" : APPLICATION_OGG,
"omdoc" : APPLICATION_OMDOC_XML,
"onepkg" : APPLICATION_ONENOTE,
"onetmp" : APPLICATION_ONENOTE,
"onetoc" : APPLICATION_ONENOTE,
"onetoc2" : APPLICATION_ONENOTE,
"opf" : APPLICATION_OEBPS_PACKAGE_XML,
"opml" : TEXT_X_OPML,
"oprc" : APPLICATION_VND_PALM,
"org" : APPLICATION_VND_LOTUS_ORGANIZER,
"osf" : APPLICATION_VND_YAMAHA_OPENSCOREFORMAT,
"osfpvg" : APPLICATION_VND_YAMAHA_OPENSCOREFORMAT_OSFPVG_XML,
"otc" : APPLICATION_VND_OASIS_OPENDOCUMENT_CHART_TEMPLATE,
"otf" : APPLICATION_X_FONT_OTF,
"otg" : APPLICATION_VND_OASIS_OPENDOCUMENT_GRAPHICS_TEMPLATE,
"oth" : APPLICATION_VND_OASIS_OPENDOCUMENT_TEXT_WEB,
"oti" : APPLICATION_VND_OASIS_OPENDOCUMENT_IMAGE_TEMPLATE,
"otp" : APPLICATION_VND_OASIS_OPENDOCUMENT_PRESENTATION_TEMPLATE,
"ots" : APPLICATION_VND_OASIS_OPENDOCUMENT_SPREADSHEET_TEMPLATE,
"ott" : APPLICATION_VND_OASIS_OPENDOCUMENT_TEXT_TEMPLATE,
"oxps" : APPLICATION_OXPS,
"oxt" : APPLICATION_VND_OPENOFFICEORG_EXTENSION,
"p" : TEXT_X_PASCAL,
"p10" : APPLICATION_PKCS10,
"p12" : APPLICATION_X_PKCS12,
"p7b" : APPLICATION_X_PKCS7_CERTIFICATES,
"p7c" : APPLICATION_PKCS7_MIME,
"p7m" : APPLICATION_PKCS7_MIME,
"p7r" : APPLICATION_X_PKCS7_CERTREQRESP,
"p7s" : APPLICATION_PKCS7_SIGNATURE,
"p8" : APPLICATION_PKCS8,
"pas" : TEXT_X_PASCAL,
"paw" : APPLICATION_VND_PAWAAFILE,
"pbd" : APPLICATION_VND_POWERBUILDER6,
"pbm" : IMAGE_X_PORTABLE_BITMAP,
"pcap" : APPLICATION_VND_TCPDUMP_PCAP,
"pcf" : APPLICATION_X_FONT_PCF,
"pcl" : APPLICATION_VND_HP_PCL,
"pclxl" : APPLICATION_VND_HP_PCLXL,
"pct" : IMAGE_X_PICT,
"pcurl" : APPLICATION_VND_CURL_PCURL,
"pcx" : IMAGE_X_PCX,
"pdb" : APPLICATION_VND_PALM,
"pdf" : APPLICATION_PDF,
"pfa" : APPLICATION_X_FONT_TYPE1,
"pfb" : APPLICATION_X_FONT_TYPE1,
"pfm" : APPLICATION_X_FONT_TYPE1,
"pfr" : APPLICATION_FONT_TDPFR,
"pfx" : APPLICATION_X_PKCS12,
"pgm" : IMAGE_X_PORTABLE_GRAYMAP,
"pgn" : APPLICATION_X_CHESS_PGN,
"pgp" : APPLICATION_PGP_ENCRYPTED,
"pic" : IMAGE_X_PICT,
"pkg" : APPLICATION_OCTET_STREAM,
"pki" : APPLICATION_PKIXCMP,
"pkipath" : APPLICATION_PKIX_PKIPATH,
"plb" : APPLICATION_VND_3GPP_PIC_BW_LARGE,
"plc" : APPLICATION_VND_MOBIUS_PLC,
"plf" : APPLICATION_VND_POCKETLEARN,
"pls" : APPLICATION_PLS_XML,
"pml" : APPLICATION_VND_CTC_POSML,
"png" : IMAGE_PNG,
"pnm" : IMAGE_X_PORTABLE_ANYMAP,
"portpkg" : APPLICATION_VND_MACPORTS_PORTPKG,
"pot" : APPLICATION_VND_MS_POWERPOINT,
"potm" : APPLICATION_VND_MS_POWERPOINT_TEMPLATE_MACROENABLED_12,
"potx" : APPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_PRESENTATIONML_TEMPLATE,
"ppam" : APPLICATION_VND_MS_POWERPOINT_ADDIN_MACROENABLED_12,
"ppd" : APPLICATION_VND_CUPS_PPD,
"ppm" : IMAGE_X_PORTABLE_PIXMAP,
"pps" : APPLICATION_VND_MS_POWERPOINT,
"ppsm" : APPLICATION_VND_MS_POWERPOINT_SLIDESHOW_MACROENABLED_12,
"ppsx" : APPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_PRESENTATIONML_SLIDESHOW,
"ppt" : APPLICATION_VND_MS_POWERPOINT,
"pptm" : APPLICATION_VND_MS_POWERPOINT_PRESENTATION_MACROENABLED_12,
"pptx" : APPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_PRESENTATIONML_PRESENTATION,
"pqa" : APPLICATION_VND_PALM,
"prc" : APPLICATION_X_MOBIPOCKET_EBOOK,
"pre" : APPLICATION_VND_LOTUS_FREELANCE,
"prf" : APPLICATION_PICS_RULES,
"ps" : APPLICATION_POSTSCRIPT,
"psb" : APPLICATION_VND_3GPP_PIC_BW_SMALL,
"psd" : IMAGE_VND_ADOBE_PHOTOSHOP,
"psf" : APPLICATION_X_FONT_LINUX_PSF,
"pskcxml" : APPLICATION_PSKC_XML,
"ptid" : APPLICATION_VND_PVI_PTID1,
"pub" : APPLICATION_X_MSPUBLISHER,
"pvb" : APPLICATION_VND_3GPP_PIC_BW_VAR,
"pwn" : APPLICATION_VND_3M_POST_IT_NOTES,
"pya" : AUDIO_VND_MS_PLAYREADY_MEDIA_PYA,
"pyv" : VIDEO_VND_MS_PLAYREADY_MEDIA_PYV,
"qam" : APPLICATION_VND_EPSON_QUICKANIME,
"qbo" : APPLICATION_VND_INTU_QBO,
"qfx" : APPLICATION_VND_INTU_QFX,
"qps" : APPLICATION_VND_PUBLISHARE_DELTA_TREE,
"qt" : VIDEO_QUICKTIME,
"qwd" : APPLICATION_VND_QUARK_QUARKXPRESS,
"qwt" : APPLICATION_VND_QUARK_QUARKXPRESS,
"qxb" : APPLICATION_VND_QUARK_QUARKXPRESS,
"qxd" : APPLICATION_VND_QUARK_QUARKXPRESS,
"qxl" : APPLICATION_VND_QUARK_QUARKXPRESS,
"qxt" : APPLICATION_VND_QUARK_QUARKXPRESS,
"ra" : AUDIO_X_PN_REALAUDIO,
"ram" : AUDIO_X_PN_REALAUDIO,
"rar" : APPLICATION_X_RAR_COMPRESSED,
"ras" : IMAGE_X_CMU_RASTER,
"rcprofile" : APPLICATION_VND_IPUNPLUGGED_RCPROFILE,
"rdf" : APPLICATION_RDF_XML,
"rdz" : APPLICATION_VND_DATA_VISION_RDZ,
"rep" : APPLICATION_VND_BUSINESSOBJECTS,
"res" : APPLICATION_X_DTBRESOURCE_XML,
"rgb" : IMAGE_X_RGB,
"rif" : APPLICATION_REGINFO_XML,
"rip" : AUDIO_VND_RIP,
"ris" : APPLICATION_X_RESEARCH_INFO_SYSTEMS,
"rl" : APPLICATION_RESOURCE_LISTS_XML,
"rlc" : IMAGE_VND_FUJIXEROX_EDMICS_RLC,
"rld" : APPLICATION_RESOURCE_LISTS_DIFF_XML,
"rm" : APPLICATION_VND_RN_REALMEDIA,
"rmi" : AUDIO_MIDI,
"rmp" : AUDIO_X_PN_REALAUDIO_PLUGIN,
"rms" : APPLICATION_VND_JCP_JAVAME_MIDLET_RMS,
"rmvb" : APPLICATION_VND_RN_REALMEDIA_VBR,
"rnc" : APPLICATION_RELAX_NG_COMPACT_SYNTAX,
"roa" : APPLICATION_RPKI_ROA,
"roff" : TEXT_TROFF,
"rp9" : APPLICATION_VND_CLOANTO_RP9,
"rpss" : APPLICATION_VND_NOKIA_RADIO_PRESETS,
"rpst" : APPLICATION_VND_NOKIA_RADIO_PRESET,
"rq" : APPLICATION_SPARQL_QUERY,
"rs" : APPLICATION_RLS_SERVICES_XML,
"rsd" : APPLICATION_RSD_XML,
"rss" : APPLICATION_RSS_XML,
"rtf" : APPLICATION_RTF,
"rtx" : TEXT_RICHTEXT,
"s" : TEXT_X_ASM,
"s3m" : AUDIO_S3M,
"saf" : APPLICATION_VND_YAMAHA_SMAF_AUDIO,
"sbml" : APPLICATION_SBML_XML,
"sc" : APPLICATION_VND_IBM_SECURE_CONTAINER,
"scd" : APPLICATION_X_MSSCHEDULE,
"scm" : APPLICATION_VND_LOTUS_SCREENCAM,
"scq" : APPLICATION_SCVP_CV_REQUEST,
"scs" : APPLICATION_SCVP_CV_RESPONSE,
"scurl" : TEXT_VND_CURL_SCURL,
"sda" : APPLICATION_VND_STARDIVISION_DRAW,
"sdc" : APPLICATION_VND_STARDIVISION_CALC,
"sdd" : APPLICATION_VND_STARDIVISION_IMPRESS,
"sdkd" : APPLICATION_VND_SOLENT_SDKM_XML,
"sdkm" : APPLICATION_VND_SOLENT_SDKM_XML,
"sdp" : APPLICATION_SDP,
"sdw" : APPLICATION_VND_STARDIVISION_WRITER,
"see" : APPLICATION_VND_SEEMAIL,
"seed" : APPLICATION_VND_FDSN_SEED,
"sema" : APPLICATION_VND_SEMA,
"semd" : APPLICATION_VND_SEMD,
"semf" : APPLICATION_VND_SEMF,
"ser" : APPLICATION_JAVA_SERIALIZED_OBJECT,
"setpay" : APPLICATION_SET_PAYMENT_INITIATION,
"setreg" : APPLICATION_SET_REGISTRATION_INITIATION,
"sfd-hdstx" : APPLICATION_VND_HYDROSTATIX_SOF_DATA,
"sfs" : APPLICATION_VND_SPOTFIRE_SFS,
"sfv" : TEXT_X_SFV,
"sgi" : IMAGE_SGI,
"sgl" : APPLICATION_VND_STARDIVISION_WRITER_GLOBAL,
"sgm" : TEXT_SGML,
"sgml" : TEXT_SGML,
"sh" : APPLICATION_X_SH,
"shar" : APPLICATION_X_SHAR,
"shf" : APPLICATION_SHF_XML,
"sid" : IMAGE_X_MRSID_IMAGE,
"sig" : APPLICATION_PGP_SIGNATURE,
"sil" : AUDIO_SILK,
"silo" : MODEL_MESH,
"sis" : APPLICATION_VND_SYMBIAN_INSTALL,
"sisx" : APPLICATION_VND_SYMBIAN_INSTALL,
"sit" : APPLICATION_X_STUFFIT,
"sitx" : APPLICATION_X_STUFFITX,
"skd" : APPLICATION_VND_KOAN,
"skm" : APPLICATION_VND_KOAN,
"skp" : APPLICATION_VND_KOAN,
"skt" : APPLICATION_VND_KOAN,
"sldm" : APPLICATION_VND_MS_POWERPOINT_SLIDE_MACROENABLED_12,
"sldx" : APPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_PRESENTATIONML_SLIDE,
"slt" : APPLICATION_VND_EPSON_SALT,
"sm" : APPLICATION_VND_STEPMANIA_STEPCHART,
"smf" : APPLICATION_VND_STARDIVISION_MATH,
"smi" : APPLICATION_SMIL_XML,
"smil" : APPLICATION_SMIL_XML,
"smv" : VIDEO_X_SMV,
"smzip" : APPLICATION_VND_STEPMANIA_PACKAGE,
"snd" : AUDIO_BASIC,
"snf" : APPLICATION_X_FONT_SNF,
"so" : APPLICATION_OCTET_STREAM,
"spc" : APPLICATION_X_PKCS7_CERTIFICATES,
"spf" : APPLICATION_VND_YAMAHA_SMAF_PHRASE,
"spl" : APPLICATION_X_FUTURESPLASH,
"spot" : TEXT_VND_IN3D_SPOT,
"spp" : APPLICATION_SCVP_VP_RESPONSE,
"spq" : APPLICATION_SCVP_VP_REQUEST,
"spx" : AUDIO_OGG,
"sql" : APPLICATION_X_SQL,
"src" : APPLICATION_X_WAIS_SOURCE,
"srt" : APPLICATION_X_SUBRIP,
"sru" : APPLICATION_SRU_XML,
"srx" : APPLICATION_SPARQL_RESULTS_XML,
"ssdl" : APPLICATION_SSDL_XML,
"sse" : APPLICATION_VND_KODAK_DESCRIPTOR,
"ssf" : APPLICATION_VND_EPSON_SSF,
"ssml" : APPLICATION_SSML_XML,
"st" : APPLICATION_VND_SAILINGTRACKER_TRACK,
"stc" : APPLICATION_VND_SUN_XML_CALC_TEMPLATE,
"std" : APPLICATION_VND_SUN_XML_DRAW_TEMPLATE,
"stf" : APPLICATION_VND_WT_STF,
"sti" : APPLICATION_VND_SUN_XML_IMPRESS_TEMPLATE,
"stk" : APPLICATION_HYPERSTUDIO,
"stl" : APPLICATION_VND_MS_PKI_STL,
"str" : APPLICATION_VND_PG_FORMAT,
"stw" : APPLICATION_VND_SUN_XML_WRITER_TEMPLATE,
"sub" : TEXT_VND_DVB_SUBTITLE,
"sus" : APPLICATION_VND_SUS_CALENDAR,
"susp" : APPLICATION_VND_SUS_CALENDAR,
"sv4cpio" : APPLICATION_X_SV4CPIO,
"sv4crc" : APPLICATION_X_SV4CRC,
"svc" : APPLICATION_VND_DVB_SERVICE,
"svd" : APPLICATION_VND_SVD,
"svg" : IMAGE_SVG_XML,
"svgz" : IMAGE_SVG_XML,
"swa" : APPLICATION_X_DIRECTOR,
"swf" : APPLICATION_X_SHOCKWAVE_FLASH,
"swi" : APPLICATION_VND_ARISTANETWORKS_SWI,
"sxc" : APPLICATION_VND_SUN_XML_CALC,
"sxd" : APPLICATION_VND_SUN_XML_DRAW,
"sxg" : APPLICATION_VND_SUN_XML_WRITER_GLOBAL,
"sxi" : APPLICATION_VND_SUN_XML_IMPRESS,
"sxm" : APPLICATION_VND_SUN_XML_MATH,
"sxw" : APPLICATION_VND_SUN_XML_WRITER,
"t" : TEXT_TROFF,
"t3" : APPLICATION_X_T3VM_IMAGE,
"taglet" : APPLICATION_VND_MYNFC,
"tao" : APPLICATION_VND_TAO_INTENT_MODULE_ARCHIVE,
"tar" : APPLICATION_X_TAR,
"tcap" : APPLICATION_VND_3GPP2_TCAP,
"tcl" : APPLICATION_X_TCL,
"teacher" : APPLICATION_VND_SMART_TEACHER,
"tei" : APPLICATION_TEI_XML,
"teicorpus" : APPLICATION_TEI_XML,
"tex" : APPLICATION_X_TEX,
"texi" : APPLICATION_X_TEXINFO,
"texinfo" : APPLICATION_X_TEXINFO,
"text" : TEXT_PLAIN,
"tfi" : APPLICATION_THRAUD_XML,
"tfm" : APPLICATION_X_TEX_TFM,
"tga" : IMAGE_X_TGA,
"thmx" : APPLICATION_VND_MS_OFFICETHEME,
"tif" : IMAGE_TIFF,
"tiff" : IMAGE_TIFF,
"tmo" : APPLICATION_VND_TMOBILE_LIVETV,
"torrent" : APPLICATION_X_BITTORRENT,
"tpl" : APPLICATION_VND_GROOVE_TOOL_TEMPLATE,
"tpt" : APPLICATION_VND_TRID_TPT,
"tr" : TEXT_TROFF,
"tra" : APPLICATION_VND_TRUEAPP,
"trm" : APPLICATION_X_MSTERMINAL,
"tsd" : APPLICATION_TIMESTAMPED_DATA,
"tsv" : TEXT_TAB_SEPARATED_VALUES,
"ttc" : APPLICATION_X_FONT_TTF,
"ttf" : APPLICATION_X_FONT_TTF,
"ttl" : TEXT_TURTLE,
"twd" : APPLICATION_VND_SIMTECH_MINDMAPPER,
"twds" : APPLICATION_VND_SIMTECH_MINDMAPPER,
"txd" : APPLICATION_VND_GENOMATIX_TUXEDO,
"txf" : APPLICATION_VND_MOBIUS_TXF,
"txt" : TEXT_PLAIN,
"u32" : APPLICATION_X_AUTHORWARE_BIN,
"udeb" : APPLICATION_X_DEBIAN_PACKAGE,
"ufd" : APPLICATION_VND_UFDL,
"ufdl" : APPLICATION_VND_UFDL,
"ulx" : APPLICATION_X_GLULX,
"umj" : APPLICATION_VND_UMAJIN,
"unityweb" : APPLICATION_VND_UNITY,
"uoml" : APPLICATION_VND_UOML_XML,
"uri" : TEXT_URI_LIST,
"uris" : TEXT_URI_LIST,
"urls" : TEXT_URI_LIST,
"ustar" : APPLICATION_X_USTAR,
"utz" : APPLICATION_VND_UIQ_THEME,
"uu" : TEXT_X_UUENCODE,
"uva" : AUDIO_VND_DECE_AUDIO,
"uvd" : APPLICATION_VND_DECE_DATA,
"uvf" : APPLICATION_VND_DECE_DATA,
"uvg" : IMAGE_VND_DECE_GRAPHIC,
"uvh" : VIDEO_VND_DECE_HD,
"uvi" : IMAGE_VND_DECE_GRAPHIC,
"uvm" : VIDEO_VND_DECE_MOBILE,
"uvp" : VIDEO_VND_DECE_PD,
"uvs" : VIDEO_VND_DECE_SD,
"uvt" : APPLICATION_VND_DECE_TTML_XML,
"uvu" : VIDEO_VND_UVVU_MP4,
"uvv" : VIDEO_VND_DECE_VIDEO,
"uvva" : AUDIO_VND_DECE_AUDIO,
"uvvd" : APPLICATION_VND_DECE_DATA,
"uvvf" : APPLICATION_VND_DECE_DATA,
"uvvg" : IMAGE_VND_DECE_GRAPHIC,
"uvvh" : VIDEO_VND_DECE_HD,
"uvvi" : IMAGE_VND_DECE_GRAPHIC,
"uvvm" : VIDEO_VND_DECE_MOBILE,
"uvvp" : VIDEO_VND_DECE_PD,
"uvvs" : VIDEO_VND_DECE_SD,
"uvvt" : APPLICATION_VND_DECE_TTML_XML,
"uvvu" : VIDEO_VND_UVVU_MP4,
"uvvv" : VIDEO_VND_DECE_VIDEO,
"uvvx" : APPLICATION_VND_DECE_UNSPECIFIED,
"uvvz" : APPLICATION_VND_DECE_ZIP,
"uvx" : APPLICATION_VND_DECE_UNSPECIFIED,
"uvz" : APPLICATION_VND_DECE_ZIP,
"vcard" : TEXT_VCARD,
"vcd" : APPLICATION_X_CDLINK,
"vcf" : TEXT_X_VCARD,
"vcg" : APPLICATION_VND_GROOVE_VCARD,
"vcs" : TEXT_X_VCALENDAR,
"vcx" : APPLICATION_VND_VCX,
"vis" : APPLICATION_VND_VISIONARY,
"viv" : VIDEO_VND_VIVO,
"vob" : VIDEO_X_MS_VOB,
"vor" : APPLICATION_VND_STARDIVISION_WRITER,
"vox" : APPLICATION_X_AUTHORWARE_BIN,
"vrml" : MODEL_VRML,
"vsd" : APPLICATION_VND_VISIO,
"vsf" : APPLICATION_VND_VSF,
"vss" : APPLICATION_VND_VISIO,
"vst" : APPLICATION_VND_VISIO,
"vsw" : APPLICATION_VND_VISIO,
"vtu" : MODEL_VND_VTU,
"vxml" : APPLICATION_VOICEXML_XML,
"w3d" : APPLICATION_X_DIRECTOR,
"wad" : APPLICATION_X_DOOM,
"wav" : AUDIO_X_WAV,
"wax" : AUDIO_X_MS_WAX,
"wbmp" : IMAGE_VND_WAP_WBMP,
"wbs" : APPLICATION_VND_CRITICALTOOLS_WBS_XML,
"wbxml" : APPLICATION_VND_WAP_WBXML,
"wcm" : APPLICATION_VND_MS_WORKS,
"wdb" : APPLICATION_VND_MS_WORKS,
"wdp" : IMAGE_VND_MS_PHOTO,
"weba" : AUDIO_WEBM,
"webm" : VIDEO_WEBM,
"webp" : IMAGE_WEBP,
"wg" : APPLICATION_VND_PMI_WIDGET,
"wgt" : APPLICATION_WIDGET,
"wks" : APPLICATION_VND_MS_WORKS,
"wm" : VIDEO_X_MS_WM,
"wma" : AUDIO_X_MS_WMA,
"wmd" : APPLICATION_X_MS_WMD,
"wmf" : APPLICATION_X_MSMETAFILE,
"wml" : TEXT_VND_WAP_WML,
"wmlc" : APPLICATION_VND_WAP_WMLC,
"wmls" : TEXT_VND_WAP_WMLSCRIPT,
"wmlsc" : APPLICATION_VND_WAP_WMLSCRIPTC,
"wmv" : VIDEO_X_MS_WMV,
"wmx" : VIDEO_X_MS_WMX,
"wmz" : APPLICATION_X_MS_WMZ,
"woff" : APPLICATION_X_FONT_WOFF,
"wpd" : APPLICATION_VND_WORDPERFECT,
"wpl" : APPLICATION_VND_MS_WPL,
"wps" : APPLICATION_VND_MS_WORKS,
"wqd" : APPLICATION_VND_WQD,
"wri" : APPLICATION_X_MSWRITE,
"wrl" : MODEL_VRML,
"wsdl" : APPLICATION_WSDL_XML,
"wspolicy" : APPLICATION_WSPOLICY_XML,
"wtb" : APPLICATION_VND_WEBTURBO,
"wvx" : VIDEO_X_MS_WVX,
"x32" : APPLICATION_X_AUTHORWARE_BIN,
"x3d" : MODEL_X3D_XML,
"x3db" : MODEL_X3D_BINARY,
"x3dbz" : MODEL_X3D_BINARY,
"x3dv" : MODEL_X3D_VRML,
"x3dvz" : MODEL_X3D_VRML,
"x3dz" : MODEL_X3D_XML,
"xaml" : APPLICATION_XAML_XML,
"xap" : APPLICATION_X_SILVERLIGHT_APP,
"xar" : APPLICATION_VND_XARA,
"xbap" : APPLICATION_X_MS_XBAP,
"xbd" : APPLICATION_VND_FUJIXEROX_DOCUWORKS_BINDER,
"xbm" : IMAGE_X_XBITMAP,
"xdf" : APPLICATION_XCAP_DIFF_XML,
"xdm" : APPLICATION_VND_SYNCML_DM_XML,
"xdp" : APPLICATION_VND_ADOBE_XDP_XML,
"xdssc" : APPLICATION_DSSC_XML,
"xdw" : APPLICATION_VND_FUJIXEROX_DOCUWORKS,
"xenc" : APPLICATION_XENC_XML,
"xer" : APPLICATION_PATCH_OPS_ERROR_XML,
"xfdf" : APPLICATION_VND_ADOBE_XFDF,
"xfdl" : APPLICATION_VND_XFDL,
"xht" : APPLICATION_XHTML_XML,
"xhtml" : APPLICATION_XHTML_XML,
"xhvml" : APPLICATION_XV_XML,
"xif" : IMAGE_VND_XIFF,
"xla" : APPLICATION_VND_MS_EXCEL,
"xlam" : APPLICATION_VND_MS_EXCEL_ADDIN_MACROENABLED_12,
"xlc" : APPLICATION_VND_MS_EXCEL,
"xlf" : APPLICATION_X_XLIFF_XML,
"xlm" : APPLICATION_VND_MS_EXCEL,
"xls" : APPLICATION_VND_MS_EXCEL,
"xlsb" : APPLICATION_VND_MS_EXCEL_SHEET_BINARY_MACROENABLED_12,
"xlsm" : APPLICATION_VND_MS_EXCEL_SHEET_MACROENABLED_12,
"xlsx" : APPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_SPREADSHEETML_SHEET,
"xlt" : APPLICATION_VND_MS_EXCEL,
"xltm" : APPLICATION_VND_MS_EXCEL_TEMPLATE_MACROENABLED_12,
"xltx" : APPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_SPREADSHEETML_TEMPLATE,
"xlw" : APPLICATION_VND_MS_EXCEL,
"xm" : AUDIO_XM,
"xml" : APPLICATION_XML,
"xo" : APPLICATION_VND_OLPC_SUGAR,
"xop" : APPLICATION_XOP_XML,
"xpi" : APPLICATION_X_XPINSTALL,
"xpl" : APPLICATION_XPROC_XML,
"xpm" : IMAGE_X_XPIXMAP,
"xpr" : APPLICATION_VND_IS_XPR,
"xps" : APPLICATION_VND_MS_XPSDOCUMENT,
"xpw" : APPLICATION_VND_INTERCON_FORMNET,
"xpx" : APPLICATION_VND_INTERCON_FORMNET,
"xsl" : APPLICATION_XML,
"xslt" : APPLICATION_XSLT_XML,
"xsm" : APPLICATION_VND_SYNCML_XML,
"xspf" : APPLICATION_XSPF_XML,
"xul" : APPLICATION_VND_MOZILLA_XUL_XML,
"xvm" : APPLICATION_XV_XML,
"xvml" : APPLICATION_XV_XML,
"xwd" : IMAGE_X_XWINDOWDUMP,
"xyz" : CHEMICAL_X_XYZ,
"xz" : APPLICATION_X_XZ,
"yang" : APPLICATION_YANG,
"yin" : APPLICATION_YIN_XML,
"z1" : APPLICATION_X_ZMACHINE,
"z2" : APPLICATION_X_ZMACHINE,
"z3" : APPLICATION_X_ZMACHINE,
"z4" : APPLICATION_X_ZMACHINE,
"z5" : APPLICATION_X_ZMACHINE,
"z6" : APPLICATION_X_ZMACHINE,
"z7" : APPLICATION_X_ZMACHINE,
"z8" : APPLICATION_X_ZMACHINE,
"zaz" : APPLICATION_VND_ZZAZZ_DECK_XML,
"zip" : APPLICATION_ZIP,
"zir" : APPLICATION_VND_ZUL,
"zirz" : APPLICATION_VND_ZUL,
"zmm" : APPLICATION_VND_HANDHELD_ENTERTAINMENT_XML,
};
