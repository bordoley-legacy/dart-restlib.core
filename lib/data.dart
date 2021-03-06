library data;

import "dart:convert";

import "package:restlib_common/collections.dart";
import "package:restlib_common/collections.immutable.dart";
import "package:restlib_common/objects.dart";
import "package:restlib_common/preconditions.dart";

import "package:restlib_parsing/parsing.dart";

import "data.internal.dart";
import "data.media_ranges.dart";
import "http.internal.dart";
import "http.dart";
import "net.dart";

part "src/data/cache_directive.dart";
part "src/data/challenge_message.dart";
part "src/data/charset.dart";
part "src/data/comment.dart";
part "src/data/content_encoding.dart";
part "src/data/content_range.dart";
part "src/data/cookie.dart";
part "src/data/entity_tag.dart";
part "src/data/expectation.dart";
part "src/data/form.dart";
part "src/data/language.dart";
part "src/data/matcheable.dart";
part "src/data/mediarange.dart";
part "src/data/product.dart";
part "src/data/range.dart";
part "src/data/range_unit.dart";
part "src/data/user_agent.dart";
part "src/data/warning.dart";



const Dictionary<String, MediaRange> DEFAULT_EXTENSION_MAP = const Dictionary.wrapMap(const <String, MediaRange>{
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
});

