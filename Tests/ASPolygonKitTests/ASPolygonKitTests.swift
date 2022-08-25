//
//  ASPolygonKitTests.swift
//  ASPolygonKitExampleTests
//
//  Created by Adrian Schoenig on 18/2/17.
//  Copyright © 2017 Adrian Schönig. All rights reserved.
//

import XCTest

import ASPolygonKit

#if canImport(UIKit)
import UIKit
#endif

@testable import ASPolygonKit

class ASPolygonKitTests: XCTestCase {
    
  func testAll() throws {
    let polygons = try polygonsFromJSON(named: "polygons-tripgo-170217")
    XCTAssertEqual(154, polygons.count)
  }

  func testCH() throws {
    let polygons = try polygonsFromJSON(named: "polygons-ch-170224")
    XCTAssertEqual(5, polygons.count)
    
    let merged = try Polygon.union(polygons)
    XCTAssertEqual(1, merged.count)
    
    XCTAssertEqual(merged.first?.encodeCoordinates(), """
      iobcHyvps@j~cAoquEhgj@jWA{AxzAnCzgD~A@hDlpb@`w@_JehAjVoheDb{xCucAjqlBtpmHo`^`zyBtrAlvzA~|IfwsArvX?{iv@htlIuj`ChvB?~P{MqPcaRpP?saVk`aDyn~DeiXoy{D`gC?
      """)
  }
  
  func testUK() throws {
    let polygons = try polygonsFromJSON(named: "polygons-uk-170217")
    XCTAssertEqual(19, polygons.count)
    
    let merged = try Polygon.union(polygons)
    XCTAssertEqual(1, merged.count)
    
    XCTAssertEqual(merged.first?.encodeCoordinates(), """
      _aisJ~nyo@?_oyo@~nh\\??`f{@nyo@lblH~tAboL~|bKs_kN?nh\\npxD??ovmHnxtI??~s`BnnqC??~m|Qn}}B??~hsXoezG??_ry@_ulL??_ulLo{vA??~dtBoljB??~{|FkkmCrkt@zoJz|x@i_@vaAxzbCgjiAnfrB??~qy@ntfG??ppHnaoA|z`BnpxDnl{U?~hbE_c{X??cro[_msCznqH?fdS
      """)
  }

  func testScandinavia() throws {
    let polygons = try polygonsFromJSON(named: "polygons-scandinavia-170217")
    XCTAssertEqual(16, polygons.count)
    
    let merged = try Polygon.union(polygons)
    XCTAssertEqual(1, merged.count)
    
    XCTAssertEqual(merged.first?.encodeCoordinates(), """
      {musLul~eCzizB}w|z@lxrGr|uD|diB~_uJd~zF{{_F|lq[cngJn`wFncpJyPvl@xdiGvtyK~yxA~olG||]l`nW`I`DiA~}DhA~y@aBi@w~E`k|P`{x@ubiA`z_G??j`mArwrFz|H?vqvE`bgClhtGnkuCnsqHnyo@~tiP_t`Boh\\odkA~wq@_{m@~tu@qrqB|juA?|ypAwapFzcn@hFf~|@_osCkF_}BcoDj|Ll_dEbiSnkkBfv{Ct~MlbLlxx\\{ftK_mEwdvD|x{@?tEcG_Cq_Cti@?}hBcv{Fsj{BempDyloH|VmfDanw^_jug@bRcxB
      """)
  }
  
  func testStaya() throws {
    let polygons = try polygonsFromJSON(named: "polygons-au-211102")
    XCTAssertEqual(7, polygons.count)
    
    let merged = try Polygon.union(polygons)
    XCTAssertEqual(1, merged.count)
    
    XCTAssertEqual(merged.first?.encodeCoordinates(), """
      ~ghgCai|h[ykhBmhuOprjAecdOfjpc@nbq@w@yBxd@w|C|fkB}hRxwzLzbyAx`bF~j{AjBjcMnrzQ??vtyK`udMhq`Bw{DbbNh`_IjqqGyKns|Mwr~BfgaFbcMpsY}~t@`ym@~{xBfl~A`J~`gRovq]?`qd@eeqBctKww\\eMkb_AlpPq~j@rn^o_d@z_k@q|H~ab@_bOaoh@iyYbMirVpeTapJlrGwvn@vcVqpo@|vc@hhCj~d@apJd~@}re@daYewB`zi@mhtAzil@wr{@xkZghNttc@yn}@w_m@mu[{oJ}oU?inX{@?ym@wkcAzzXuyiArbMykx@sbM_`~@~aW}xeA}yJcyd@c}Ij}Hw|zHswg@do@mcxLuu~K?j}@reeGeunRg`]kButH
      """)
  }
  
  func testSwitzerland() throws {
    let polygons = [
      "cuq_Hwgcn@?_beJhqv@ovaA~{JloAl_p@`ieLwnsB?",
      "yeb{Gq`od@e`ErfGqpTsv_@?evzGcop@w_dLrkCufQn|iAa~PgfAtm|V"
    ].map(Polygon.init(encoded:))

    let merged = try Polygon.union(polygons)
    XCTAssertEqual(1, merged.count)
    
    XCTAssertEqual(merged.first?.encodeCoordinates(), """
      cuq_Hwgcn@?_beJhqv@ovaAhdJljAl`CkxOn|iAa~PgfAtm|Ve`ErfGqpTsv_@?evzG
      """)
  }

  func testGermanyIssue() throws {
//    do {
      let polygons = [
        "_j_tHqf}l@kwC{}f@eyGssiPqmdEi`yBauQbz`Irzz@vwdGjxlAt|_Dda{Aw{Z",
        "aeltHewv{@~iFvbqLbdlEy~zAu|MuwfAcUswoCotcEgzzBUor@"
      ].map(Polygon.init(encoded:))

      let merged = try Polygon.union(polygons)
      XCTAssertEqual(1, merged.count)
      
      XCTAssertEqual(merged.first?.encodeCoordinates(), """
        _j_tHqf}l@ea{Av{ZkxlAu|_Dszz@wwdG`uQcz`IpmdEh`yBx}@tmzB~sbExezBbUrwoCt|MtwfAskkExszA
        """)

//    } catch PolygonUnionError.polygonTooComplex(let steps) {
//      let stepsGeoJSON: [String: Any] = [
//        "type": "FeatureCollection",
//        "features": steps.flatMap { $0.toGeoJSON(startOnly: false) }
//      ]
//      try XCTest.save(
//        try JSONSerialization.data(withJSONObject: stepsGeoJSON, options: []),
//        filename: "steps", extension: "geojson"
//      )
//
//      let startGeoJSON: [String: Any] = [
//        "type": "FeatureCollection",
//        "features": steps.flatMap { $0.toGeoJSON(startOnly: true) }
//      ]
//      try XCTest.save(
//        try JSONSerialization.data(withJSONObject: startGeoJSON, options: []),
//        filename: "start", extension: "geojson"
//      )
//      XCTFail("Merged failed. See debug info.")
//    }
  }
  
  func testGermanyIssueDueToImprecision() throws {
    let polygons = [
      "eup`Hivo|@qfcC{o`Coo{@ohoBa}Mofg@hv}CatiCpgr@zr`LwhA`bB??",
      "e`tbH{s{s@{azEytvLny|AiooAvl|@jvpBrhcClw_CgmBv}CkdDfuCkzz@h`kG??"
    ].map(Polygon.init(encoded:))

    let merged = try Polygon.union(polygons)
    XCTAssertEqual(1, merged.count)
    
    XCTAssertEqual(merged.first?.encodeCoordinates(), """
      e`tbH{s{s@{azEytvLha|AqznAqiM}qe@hv}CatiCpgr@zr`LwhA`bB??giAziBkdDfuC
      """)
  }
  
  func testGermany() throws {
    let polygons = try polygonsFromJSON(named: "germany-input")
    XCTAssertEqual(20, polygons.count)

    let merged = try Polygon.union(polygons)
    XCTAssertEqual(merged.count, 1)
    
    XCTAssertEqual(merged.first?.encodeCoordinates(), """
      gz|lIskyp@s|oAsah@bzHe`QbeLkxThiPuxJzH{hF`~BmiIk[ylDfUuaBkeAefCe@ooGxr@{cBiu@kuDdj@mhOxvCgwNjFa~P~aD__VjtBflA~qBoaApf@cdOo~Cc`E{n@abAcVsnElzAo|Byg@m_GwpIm`Xd_AyxE`}Cdn@h}D{iW`y@ukl@hr@}pq@byZgwe@n_QwlvDt_k@oxy@chlBmqcKzw}Dw_mBdiB|aCjwHyv@ttAxU~kQowH`yAg`@baAbSh`C}QruCcwA`}G_NrtBqhEblIrg@vgEoUneDe|@f|@sjDxmFwXxBurAz_Ise@`mIuyD~yDst@trGoc@g@ihC`uBucAvkJhxHjuCtwE~cFefChaPhqEpwIhbQrxGrgVr_N_fB@dd@`i@bKbfDz{DtfB}i@tm@gfOnuFcpJzvCwcMpjQwgWjtGqgVdhHqjI|rFdrDxdFowDzpHjkHzcD~sHvpXmkHreGe_Wx_OnTdvGjfDfuCcgHhrDmdEtiH|rCZmG~|@rf@@???blDpmBrf@rqA~wB}uAneB`NnpF~qC`uAjzBbjJlzNpnEojI~mFm{BpcFqpAxsDecJfaEadC|wI{w@toGjhItuAchBviBa@lv@e~KfgD}~IxiA_`P`iGe~EtsEj_AzkEqnBvzEhCd~HgrJpsGdPb{InwDn}KztAlaH|sBx`D`xAjbFr{Cf~FhyB`^byA`pDrt@t~FbvHruAbqD~vAucA`fJldEmDxpNsuF|oU{rLquEbcBrzIwjApuEqtKmbFwrAhvIqvDlyNd`B~lEmnDhiThrGx{Dbb@itJ~fEdn@xmBcsOdvHl{BxjAvnZjyCdwBxdJrne@o_@dlLn~B|nD{\\~lE~{GdPflC|zKnj@~vXrr@ls\\`yJdwBnjHlpLwr@p|H}mEnwDj~IhxHvpAbgHk|BzyErhP`gHjOhi_@teKflAf_FbsO{iIleVzoC`{@sf@`pJfyFvoHiyA|aOreBtmThbChhCpaBa]dfAdhB}c@fjBtfBj|B??rfAhkAj@rxDpgDoFdwCtcGdcEsWds@hfDpjKqGwLhxH{xCv}CqpCa{@wnDbgHgrBytAmO|uGa}H~cClZ~uGvjFsnBdhChoFjfA}uGreFwdGxyDqwDljIhhChjFcsOxvBhhCdN_kFroCgkGfbBihCv^gbEtfA_fBhRibEfqC_~J~_Fx}ChoCqeQj|O`wM~~GfjB~nDxrMftHobFpsBsnNnbL_hAj@a`EjyLasCdjB{xFmY{dArlRslCtcDgoQjhG}gAp_CkfD|ZoeKewBzi@~kBacUh`GmpLxrYsd]djDre@roCcvHizAqmHftMsvVvjLuaB|wEmpLs`CucAkXeaKhsD}eMj`LsqGcl@kvIb|JeaKbtJeeIbfG|nD`bBvaB~hAauEtzA|S_Pv_C|dCse@`qBre@pu@_z@fyC}ZrvAhyBv~AfB|eBha@bOtkAn`BjrB`Nbh@ibAru@noEng@ruCzaCoxCrrLixE|zKlgAh{AqfDrgKdvDbiGyK|nD`cGchBvuIthEviBchB`fLjdEddIplNt_E|rNqGnnM``BliIdPjkHbhCfaKzhGxkJvg@|nDrVpwJrnF`pDznFvmIx~AvoDvgB`Z`qJ{nOtzL{tMzdAiqBrkR}|M`yHtoHfhBnjCd~Ae_@dxBrt@vcCfsDnkAcnKcnBwuFpbBsdF~zCyjEpyCka@xlDctCdaEpcFruBsG~iH`sCpiHmT||EbvHyq@vfFw`JzzVweC~eBcIh`FsuC`bDiqBmTgxDabDw`EfxHsxAen@_gBxrM~lA|lEgSf|FlpFv}Cl@j|Gnt@`dChCl{BgeD`kF_kDddDwlB`]pkAptKggAzwFtn@dmFdtAnjC{cCjuDw_Hq}BppDfbEdtAxqHbqIuhEncFal@nk@`sFk]j~FmQvgTw{@rlCh~BtrXzoBzpCgp@bfNhStlO|[zvL~vC`uBnkCaNvxBjwCh}@xiKud@vcM~lD`kF`mDyuFvqAvaB{Q~xL|hBpmHt~D`l@dY`~Pu~EeuChjE`|Qlp@pqRugAzpNemE{rB{oF~qIuaAqGz^fzG{uB~eBwoEwhE`v@|eMnj@jmGcjCrjD{^bgHqqAzaC_v@jjNxyDdwB}NbvH{^`zFsnApuE~aJbjAjPoyC``C}i@rhF{i@zhDh~FrtD_Na\\~tBdcFzqHbiDzpCtzAvpBlvEtuQuZthEfi@vuFumEwX{dAqfEszAbjAaiIiqE_\\bgH`yAzK~^bqDyt@|_DrgChhCasHljC}^|x@_|@`]ecBgqEwhA`bB??giAziBkdDfuC~[vfFmqCzrB_\\wXyhBjxCsqAzKtd@~gG}jB`|E`uBvXshCnbL}dCal@cfBtAok@nfBpA`lCneA`_B~jAps@xpAha@fc@dn@fdChCjjA|{g@k`Sr~Vc_Fx|i@lMvpBwmAxqB|Fj}Amb@bbDsi@pzCap@bnKdtAzfGr~@njC`zAfaKas@vnCatBha@mt@jhCg{BoTkt@pwDetAzaCdm@vpB`jA}_DhdAst@p_Cvv@n@dwBy_BthEmZ`kFeuCyeAoRvsAu`A~j@gr@aN{z@st@kZ{cB}_A|aCxu@pnBwQf}@ooBhp@ofAxjAm\\jz@|pB{Kx`CdfC}q@|hBudC~dAaaB_NeFdmFzpByeAbgAneKm@pwDfiDpfEfkBhCfrCxqHvrA_fBbjAnaAddBowD_Lw_C~_Am{BjCoqFitArVggAe|Fxk@sqAeu@{~Cr\\g{ApxAewBzyB`]|[nyC|lBkp@prCtjDcIjuDgaCePitApuE~oAztAfdBrqGh`@oyCdc@oaA|eAre@hwAb}KijAfbEndAbjAsWfaKweBlsEseCbPmZh`F~bAxlDmaBzcBfaCthEfjAdpExQdcDzjBl`Alj@btCuq@dkAhwArbGi`@toHsOjzBfzAtt@kXdmFapAnaAodAsVaeB~eBoEt~Bbk@r{Cwa@liClaBzi@hwAv_CbpAhlGhjApkIoEvkDqyAzoCkgAfjBiu@}LdAiyBan@ylDy{@l`A}h@lE}NhjBdoBhcEiKdaBg{@~~BwrAiU_jJlpLy{F|gA{cN}vAefR{{D}jJs{C_fGazF{qIdeI_fIbP}`Gk_A_qF{pC{rJaaJcbPakFyjCsqG{nJxv@mdJoyCoeHcyAc|BeoEmiFuIwoEvg@{`KooGynN}`UiqDwX_fGelLc^sqGmjN_tHqyLkjLI\\wGuHMM?AiqAgzA_bCvnTu{F`mQ~J|dBqIjb@}p@d_@qoBdaEnaBrnBsj@rjDzbBrlCsqDprLr~AruE`KdmNhSrQkgG|_[euGfkGe|H|aOtgEt`H`aFb}KuRpsQ{]x`IyeChxHb_DjfDt`@vfF{aNduCyfBdcJuxA|nDft@~lEai@|wFbfEijBzkEf|Fm~AliIfQfzGqyD~jFytBihCucAbPzd@|_DasGdmFedDb{@sqA|}DgtIzxKqmCkfD{xEjkHaiBwXahGdxSrrAh_LakPnaA{sAslCyhBr{C{lCcwBg`FwmIkoEdPo{HycMweMk_A_gAwv@ey@fxH|E|_Dgr@b`EitDp~GxtAbyAeChhCqxCbjAokFr_NcmDpnBu|B_Nc`@pdFwrHtqGuxJfsDsnJchBe}C_wA_lAdn@yjDuaBgRwfFw~BqGkqAl{BedCk_AqHm{Bi|A}gAub@waB{zAa_KqhBzK{~DadCo^qfEprAihCeiBo~GwnGhlMklLssFc{@x{DczD|i@su@fdDzTjjNmaDdmFw`GlyCm|J{lPyEvrMciRjqKjUvmO{jJre@oqCdeIc}BqpAln@wnCmn@g{A_yBj_A}nAe_@qmA_vGlp@qbAmqBmoA{nAlr@{eB`N{eB}gA{MnfE{d@cAm_@dmFm_CvIw\\`jAuwC{aCrWnjIsn@`xAvnA`kIef@`qAkcCk}AsjAzpCqcAlk@`@bUwzAaNkyA~gAqhC}mJdaEmsE_nCglAeiEuqGyMw_CctFerJexBawMatBrbGzt@p_BlLduCq`BtaBycGd_@cQ}eBofB~hA}cF_cIc_JkjHmT_fB_iCc~EayCf}@gs@wXaWbyAqyIcjAwgJ`l@opBjfDotE~qCkx@zaCugBflA}~AviEsoAhCwtEctCc~Br|NmfF~y@e|@e|@ieBteFkBf}FisAfn@igBkpFoc@fRmy@cPoYloAunAe_@qpApwD}gA|[ceBumCvd@}}Ds~@efCc^miCsyB_aDb_B}fGbb@ecJcyAiC{RztAeZxh@k~A`l@oY`iA}HxtAqKb|@km@m`AcXip@fNor@ah@wzDh`BubG`b@dP|Jvu@tp@}fA`j@omB{RupBfJctCkk@waBhq@mvDb}Awg@|Bu`Hx_BehBzVoyCwgBgRsz@~tBucBut@z_Ag_Lhy@g{AueEo_M_GurAgdEkgX|cBsdFpUsGwjDglJuh@ut@csCsWy{@oeEiwBhRi@hyBqj@lEwgEteLys@vmIgkBbAckBwv@mr@q~GejAwXcm@k_Ac`Cal@iBcdOoeAerDuyCkq@ewA}_Dyi@uH{]axG}oDmxCyfBqs@uTs}B`PgxBggAgnFkrArgBeNzNcNbq@oaBrcAqyA`N}rKuqGqkG~gAsRbwBeiDxlDuzE~tBldEzyEaaBr`Sis@lTqEhlMg{Dv{O}`Fse@wfCr}BkgBePjZakF}kA{i@wJ}pC{zBboEmhDal@kt@p_BceC_uB_dAugK}BoiUxkA}hFkt@{wFvoA{gLoi_@qnBe`EwnCi|A`l@gwPuuQmsKgsDitRnaAs_BfuCgjMakFy_U~tB_h@lgU}bA~pOqm_@j`RedJnyq@{eLd|FomCpnBeceB{dgF?A
      """)
  }
  
  func testBelgium() throws {
    // Useful for debugging:
    // `po String(decoding: try JSONSerialization.data(withJSONObject: startLink.line.geoJSON, options: []), as: UTF8.self)`
    
    let polygons = [
      "sjaxHiuiXklJauNygDzpCwKmqW|xBwkJuvRv_CwdDo`^zvAgvChqFnpAzs@wyP}~Ns`YphC{_OleKpd@glDuqM_|B{zPegBkiCdaBkyHvcGsxDzqFruEhxGqhJvfEqs@qp@_`JrqBijHdiFdiBbQ}bTehAkb@neAwcM_dBasCatBkmGx[yiEdvDimGhlGe_@r{CaoPriA_\\eSecP|[krEtxDyJmrAaiG|oD{vFp|C`uHfuAoyCl}GxdG}YxqBtoDxcBj_@ikBv{EzuAtyC`}E~{@qnEjuGjkEbpEr}Hzk@d}DhpHm|@piAutF|kDwg@jfFrlC?hdjHsziB???",
      "w|xtHugo\\byrB?rxPl}XzqNf`@xiHzla@hlAvtL}}Ap`SwyA~jFhlAbcUm~CtjJo}Fnc@y{D}_DexBwfL{mFdaEmmCgBzPxsGqg@bcDuvNeuCerGakL}|AzyEj`B~eBjKpxDsoI|mJieGxnI`fDr`YyaCj~FnDxgFuLprLldFvu@bu@vnCehDrsFw_GvbBawOtWyzErbG`_@nyTyyApV{}Bm{BsfAdmFf}ClgD~cBpoMgfEdeOecA|dBk_Ol{BeqHlxCmwAu~BqzDnr@_PvuF_zAn~Ak}AtW{vBz|A?icdI??",
      "_{nxHa`{QoiBcmt@raGe~B|yJjKh|Dq|HwCshPiqF`{@m|BkmMp~De~Yh}AguLdgH_Ne`AygPbIw`Gtl@y}@ouBgsGmfAo~DdEclFwlHoiU|wiB??dz_EyiFt{InuAxnFnXh{JvtCh{Ln{Dr~A~rC`cEm{A|aC|LxcBwnBliC|^jfD_gAjdEi}NfwNq_@n}MitFh`FoiAopAoyIfyBkkDyyEslGfgCgSvqBo}A~eBecAe_@{mHtrA{iCdwBglt@_bkB??",
      "}qcpHazj\\oyL_]{}DayBy_G}jG_kAfh@}RjvFiUlpAkytB??ayiDw_@c}AuPmdDecCk}EvdD{~F_pA}fMllBqfEmk@akFf`@uvKtv@ihCnxBgQra@_gM|gJ}bInBgfDlbBe_AxDe|H|mBixDlqLdhHrqD`}Et|Dw_CmQotKvjA_lKhbExXxc@wyDfzD{i@pyHb`E~eDmzHvhDyv@heCjdIytB|eFfzExcFvq@eb@pnAptA~n@nmIf}B`fDle@l~Bv~Cgy@vfDoYbfAhlGvgDem@tuAvnCkx@riDuiD_\\a\\`pDzqAb^|UnoGizCroBf]hlGnaG|Z`wAfaKlaFf`BteBrbCbnDu[`fDjrGdoB_xBf~CrvDhnA`jF|}EzpBr_BfvBbtCq~GzrBx}Cb_Kvv@an@ujD~nIqmHbmC_NmImdEnqB}pCd~DneBppActFbpDjSzgDfsDjiFd_@~eC|lEpo@h}CzXv_Fde@~qMak@~uLrvFrbD_tBjmGngDloR{wCv|CknLdpBmoEfzJljAt{IapCdaByrCi~CqbDllHo~@lqWyfJnvJeoGdgTb{@dgKqd@jyKw{FscBwtEjsCa~CgvDu`Dcb@wdDncFe|AdeIs{C_N_oA}pC??"
    ].map(Polygon.init(encoded:))

    let merged = try Polygon.union(polygons)
    XCTAssertEqual(1, merged.count)
    
    XCTAssertEqual(merged.first?.encodeCoordinates(), """
      sjaxHiuiXklJauNygDzpCwKmqW|xBwkJuvRv_CwdDo`^zvAgvChqFnpAzs@wyP}~Ns`YphC{_OleKpd@glDuqM_|B{zPegBkiCdaBkyHvcGsxDzqFruEhxGqhJvfEqs@qp@_`JrqBijHdiFdiBbQ}bTehAkb@neAwcM_dBasCatBkmGx[yiEdvDimGhlGe_@r{CaoPriA_\\eSecP|[krEtxDyJmrAaiG|oD{vFp|C`uHfuAoyCl}GxdG}YxqBtoDxcBj_@ikBv{EzuAtyC`}E~{@qnEjuGjkEbpEr}Hzk@d}DhpHm|@piAutF|kDwg@rxC`}A?{Zw_@c}AuPmdDecCk}EvdD{~F_pA}fMllBqfEmk@akFf`@uvKtv@ihCnxBgQra@_gM|gJ}bInBgfDlbBe_AxDe|H|mBixDlqLdhHrqD`}Et|Dw_CmQotKvjA_lKhbExXxc@wyDfzD{i@pyHb`E~eDmzHvhDyv@heCjdIytB|eFfzExcFvq@eb@pnAptA~n@nmIf}B`fDle@l~Bv~Cgy@vfDoYbfAhlGvgDem@tuAvnCkx@riDuiD_\\a\\`pDzqAb^|UnoGizCroBf]hlGnaG|Z`wAfaKlaFf`BteBrbCbnDu[`fDjrGdoB_xBf~CrvDhnA`jF|}EzpBr_BfvBbtCq~GzrBx}Cb_Kvv@an@ujD~nIqmHbmC_NmImdEnqB}pCd~DneBppActFbpDjSzgDfsDjiFd_@~eC|lEpo@h}CzXv_Fde@~qMak@~uLrvFrbD_tBjmGngDloR{wCv|CknLdpBmoEfzJljAt{IapCdaByrCi~CqbDllHo~@lqWyfJnvJeoGdgTb{@dgKqd@jyKw{FscBwtEjsCa~CgvDu`Dcb@wdDncFe|AdeIs{C_N_oA}pCoyL_]{}DayBy_G}jG_kAfh@}RjvFiUlpAk@?vyNvaVzqNf`@xiHzla@hlAvtL}}Ap`SwyA~jFhlAbcUm~CtjJo}Fnc@y{D}_DexBwfL{mFdaEmmCgBzPxsGqg@bcDuvNeuCerGakL}|AzyEj`B~eBjKpxDsoI|mJieGxnI`fDr`YyaCj~FnDxgFuLprLldFvu@bu@vnCehDrsFw_GvbBawOtWyzErbG`_@nyTyyApV{}Bm{BsfAdmFf}ClgD~cBpoMgfEdeOecA|dBk_Ol{BeqHlxCmwAu~BqzDnr@_PvuF_zAn~Ak}AtWci@~_@?vFyiFt{InuAxnFnXh{JvtCh{Ln{Dr~A~rC`cEm{A|aC|LxcBwnBliC|^jfD_gAjdEi}NfwNq_@n}MitFh`FoiAopAoyIfyBkkDyyEslGfgCgSvqBo}A~eBecAe_@{mHtrA{iCdwBglt@_bkBoiBcmt@raGe~B|yJjKh|Dq|HwCshPiqF`{@m|BkmMp~De~Yh}AguLdgH_Ne`AygPbIw`Gtl@y}@ouBgsGmfAo~DdEclF{dGckRqi@?
      """)
  }
  
  func testInvariantToShuffling() throws {
    let polygons = try polygonsFromJSON(named: "polygons-uk-170217")
    XCTAssertEqual(19, polygons.count)
    
    let _ = try (1...100).map { _ in
      let shuffled = polygons.shuffled()
      let merged = try Polygon.union(shuffled)
      XCTAssertEqual(1, merged.count)
      
      XCTAssertEqual(merged.first?.encodeCoordinates(), """
        _aisJ~nyo@?_oyo@~nh\\??`f{@nyo@lblH~tAboL~|bKs_kN?nh\\npxD??ovmHnxtI??~s`BnnqC??~m|Qn}}B??~hsXoezG??_ry@_ulL??_ulLo{vA??~dtBoljB??~{|FkkmCrkt@zoJz|x@i_@vaAxzbCgjiAnfrB??~qy@ntfG??ppHnaoA|z`BnpxDnl{U?~hbE_c{X??cro[_msCznqH?fdS
        """)
    }
  }

  func testOCFailure() throws {
    var grower = Polygon(pairs: [ (4,0), (4,3), (1,3), (1,0) ])
    let addition = Polygon(pairs: [ (5,1), (5,4), (3,4), (3,2), (2,2), (2,4), (0,4), (0,1) ])
    let merged = try grower.union(addition)
    XCTAssertTrue(merged)
    XCTAssertEqual(12, grower.points.count)
  }
  
  func testSinglePointFailure() throws {
    var grower = Polygon(pairs: [ (53.5,-7.77), (52.15,-6.25), (51.2,-10) ])
    let addition = Polygon(pairs: [ (53.4600,-7.77), (54,-10), (55,-7.77) ])
    let merged = try grower.union(addition)
    XCTAssertTrue(merged)
    XCTAssert(grower.points.count > 1)
  }
  
  func testPolygonContains() {
    let addition = Polygon(pairs: [ (53.4600,-7.77), (54,-10), (55,-7.77) ])
    
    XCTAssert( addition.contains(Point(latitude: 53.5, longitude: -7.77), onLine: true))
    XCTAssert(!addition.contains(Point(latitude: 53.5, longitude: -7.77), onLine: false))
  }

  func testUnsuccessfulUnion() throws {
    var grower = Polygon(pairs: [ (60.0000,-5.0000), (60.0000,0.0000), (56.2000,0.0000), (56.2000,-5.0000) ] )
    let addition = Polygon(pairs: [ (56.2500,-5.0000), (56.2500,0.0000), (55.9500,-1.8500), (55.1700,-5.7700) ] )
    
    let merged = try grower.union(addition)
    XCTAssertTrue(merged)
    XCTAssert(grower.points.count > 1)
  }
}


extension ASPolygonKitTests {
  static func url(filename: String, ofType fileType: String = "json") -> URL {
    let sourceFile = URL(fileURLWithPath: #file)
    let directory = sourceFile.deletingLastPathComponent()
    let resourceURL =
      directory
        .appendingPathComponent("data", isDirectory: true)
        .appendingPathComponent(filename)
        .appendingPathExtension(fileType)
    return resourceURL
  }

  func polygonsFromJSON(named name: String) throws -> [ASPolygonKit.Polygon] {
    guard
      let dict = try contentFromJSON(named: name) as? [String: Any],
      let encodedPolygons = dict ["polygons"] as? [String]
      else { preconditionFailure() }
    
    return encodedPolygons.map { Polygon(encoded: $0) }
  }
  
  
  func contentFromJSON(named name: String) throws -> Any {
    let url = Self.url(filename: name)
    let data = try Data(contentsOf: url)
    return try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0))
  }
}

extension ASPolygonKit.Polygon {
  init(encoded: String) {
    let points = Point.decodePolyline(encoded)
    self.init(points: points)
  }
}

extension XCTest {
  static func save(_ data: Data, filename: String, extension fileExtension: String) throws {
    // TODO: In Swift 5.3, we can use proper resources
    // See
    // - https://stackoverflow.com/questions/47177036/use-resources-in-unit-tests-with-swift-package-manager
    // - https://stackoverflow.com/questions/39815054/how-to-include-assets-resources-in-a-swift-package-manager-library
    
    let thisSourceFile = URL(fileURLWithPath: #file)
    let thisDirectory = thisSourceFile.deletingLastPathComponent()
    let path = thisDirectory
      .appendingPathComponent(filename)
      .appendingPathExtension(fileExtension)
    return try data.write(to: path)
  }
}
