if !exists("main_syntax")
  if exists("b:current_syntax")
    finish
  endif

  let main_syntax = 'javascript'
endif

syntax sync fromstart

syntax match shebang "^#!.*"
highlight link shebang Comment

syntax region jsInJsdocExample matchgroup=Snip start="^\s*\* @example" end="\(^\s*\* [^[:space:]]\)\@=" containedin=@javaScriptComment contains=@javaScriptAll
highlight link Snip SpecialComment

syntax cluster    htmlJavaScript                      contains=@javaScriptAll,javaScriptBracket,javaScriptParen,javaScriptBlock,javaScriptParenError
syntax cluster    javaScriptAll                          contains=javaScriptComment,javaScriptLineComment,javaScriptDocComment,javaScriptString,javaScriptRegexpString,javaScriptNumber,javaScriptFloat,javaScriptLabel,javaScriptSource,javaScriptWebAPI,javaScriptOperator,javaScriptBoolean,javaScriptNull,javaScriptFuncKeyword,javaScriptConditional,javaScriptGlobal,javaScriptRepeat,javaScriptBranch,javaScriptStatement,javaScriptGlobalObjects,javaScriptMessage,javaScriptIdentifier,javaScriptExceptions,javaScriptReserved,javaScriptDeprecated,javaScriptDomErrNo,javaScriptDomNodeConsts,javaScriptHtmlEvents,javaScriptDotNotation,javaScriptBrowserObjects,javaScriptDomObjects,javaScriptAjaxObjects,javaScriptPropietaryObjects,javaScriptDomMethods,javaScriptHtmlElemProperties,javaScriptDomProperties,javaScriptEventListenerKeywords,javaScriptEventListenerMethods,javaScriptAjaxProperties,javaScriptAjaxMethods,javaScriptFuncArg
syntax cluster    javaScriptExpression                contains=@javaScriptAll,javaScriptBracket,javaScriptParen,javaScriptBlock,javaScriptParenError,@htmlPreproc

syntax keyword    javaScriptAjaxMethods               onreadystatechange abort getAllResponseHeaders getResponseHeader open send setRequestHeader
syntax keyword    javaScriptAjaxObjects               XMLHttpRequest
syntax keyword    javaScriptAjaxProperties            readyState responseText responseXML statusText
syntax keyword    javaScriptBoolean                   true false
syntax keyword    javaScriptBranch                    break continue
syntax keyword    javaScriptBrowserObjects            window navigator screen history location
syntax keyword    javaScriptCommentTodo               TODO FIXME XXX TBD contained
syntax keyword    javaScriptConditional               if else switch
syntax keyword    javaScriptDomErrNo                  INDEX_SIZE_ERR DOMSTRING_SIZE_ERR HIERARCHY_REQUEST_ERR WRONG_DOCUMENT_ERR INVALID_CHARACTER_ERR NO_DATA_ALLOWED_ERR NO_MODIFICATION_ALLOWED_ERR NOT_FOUND_ERR NOT_SUPPORTED_ERR INUSE_ATTRIBUTE_ERR INVALID_STATE_ERR SYNTAX_ERR INVALID_MODIFICATION_ERR NAMESPACE_ERR INVALID_ACCESS_ERR
syntax keyword    javaScriptDomMethods                createTextNode createElement insertBefore replaceChild removeChild appendChild  hasChildNodes  cloneNode  normalize  isSupported  hasAttributes  getAttribute  setAttribute  removeAttribute  getAttributeNode  setAttributeNode  removeAttributeNode  getElementsByTagName  hasAttribute  getElementById adoptNode close compareDocumentPosition createAttribute createCDATASection createComment createDocumentFragment createElementNS createEvent createExpression createNSResolver createProcessingInstruction createRange createTreeWalker elementFromPoint evaluate getBoxObjectFor getElementsByClassName getSelection getUserData hasFocus importNode
syntax keyword    javaScriptDomNodeConsts             ELEMENT_NODE ATTRIBUTE_NODE TEXT_NODE CDATA_SECTION_NODE ENTITY_REFERENCE_NODE ENTITY_NODE PROCESSING_INSTRUCTION_NODE COMMENT_NODE DOCUMENT_NODE DOCUMENT_TYPE_NODE DOCUMENT_FRAGMENT_NODE NOTATION_NODE
syntax keyword    javaScriptDomObjects                document event HTMLElement Anchor Area Base Body Button Form Frame Frameset Image Link Meta Option Select Style Table TableCell TableRow Textarea
syntax keyword    javaScriptDomProperties             nodeName  nodeValue  nodeType  parentNode  childNodes  firstChild  lastChild  previousSibling  nextSibling  attributes  ownerDocument  namespaceURI  prefix  localName  tagName
syntax keyword    javaScriptDeprecated                escape unescape all applets alinkColor bgColor fgColor linkColor vlinkColor xmlEncoding
syntax keyword    javaScriptEventListenerKeywords     blur click focus mouseover mouseout load item
syntax keyword    javaScriptEventListenerMethods      scrollIntoView  addEventListener  dispatchEvent  removeEventListener preventDefault stopPropagation
syntax keyword    javaScriptExceptions                try catch throw finally Error EvalError RangeError ReferenceError SyntaxError TypeError URIError
syntax keyword    javaScriptFuncKeyword               function contained
syntax keyword    javaScriptGlobal                    self top parent
syntax keyword    javaScriptGlobalObjects             Array Boolean Date Function Math Number Object RegExp String
syntax keyword    javaScriptHtmlElemProperties        className  clientHeight  clientLeft  clientTop  clientWidth  dir  href  id  innerHTML  lang  length  offsetHeight  offsetLeft  offsetParent  offsetTop  offsetWidth  scrollHeight  scrollLeft  scrollTop  scrollWidth  style  tabIndex  target  title

syntax case ignore
syntax keyword    javaScriptHtmlEvents                onblur onclick oncontextmenu ondblclick onfocus onkeydown onkeypress onkeyup onmousedown onmousemove onmouseout onmouseover onmouseup onresize onload onsubmit
syntax case match

syntax keyword    javaScriptIdentifier                arguments this let var void yield
syntax keyword    javaScriptLabel                     case default
syntax keyword    javaScriptMessage                   alert confirm prompt status
syntax keyword    javaScriptNull                      null undefined
syntax keyword    javaScriptOperator                  delete new instanceof typeof
syntax keyword    javaScriptPropietaryMethods         attachEvent detachEvent cancelBubble returnValue
syntax keyword    javaScriptPropietaryObjects         ActiveXObject
syntax keyword    javaScriptPrototype                 prototype
syntax keyword    javaScriptRepeat                    do while for in
syntax keyword    javaScriptReserved                  abstract enum int short boolean export interface static byte extends long super char final native synchronized class float package throws const goto private transient debugger implements protected volatile double import public
syntax keyword    javaScriptSource                    import export
syntax keyword    javaScriptStatement                 return with
syntax keyword    javaScriptWebAPI                    AbstractWorker AnalyserNode AnimationEvent App Apps ArrayBuffer ArrayBufferView Attr AudioBuffer AudioBufferSourceNode AudioContext AudioDestinationNode AudioListener AudioNode AudioParam AudioProcessingEvent BatteryManager BiquadFilterNode Blob BlobBuilder BlobEvent CallEvent CameraCapabilities CameraControl CameraManager CanvasGradient CanvasImageSource CanvasPattern CanvasPixelArray CanvasRenderingContext2D CaretPosition CDATASection ChannelMergerNode ChannelSplitterNode CharacterData ChildNode ChromeWorker ClipboardEvent CloseEvent Comment CompositionEvent Connection Console ContactManager ConvolverNode Coordinates CSS CSSConditionRule CSSGroupingRule CSSKeyframeRule CSSKeyframesRule CSSMediaRule CSSNamespaceRule CSSPageRule CSSRule CSSRuleList CSSStyleDeclaration CSSStyleRule CSSStyleSheet CSSSupportsRule CustomEvent
syntax keyword    javaScriptWebAPI                    DataTransfer DataView DedicatedWorkerGlobalScope DelayNode DeviceAcceleration DeviceLightEvent DeviceMotionEvent DeviceOrientationEvent DeviceProximityEvent DeviceRotationRate DeviceStorage DeviceStorageChangeEvent DirectoryEntry DirectoryEntrySync DirectoryReader DirectoryReaderSync Document DocumentFragment DocumentTouch DocumentType DOMConfiguration DOMCursor DOMError DOMErrorHandler DOMException DOMHighResTimeStamp DOMImplementation DOMImplementationList DOMImplementationSource DOMLocator DOMObject DOMParser DOMRequest DOMString DOMStringList DOMStringMap DOMTimeStamp DOMTokenList DOMUserData DynamicsCompressorNode
syntax keyword    javaScriptWebAPI                    Element ElementTraversal Entity EntityReference Entry EntrySync ErrorEvent Event EventListener EventSource EventTarget Extensions File FileEntry FileEntrySync FileError FileException FileList FileReader FileSystem FileSystemSync Float32Array Float64Array FMRadio FocusEvent FormData GainNode Geolocation History
syntax keyword    javaScriptWebAPI                    HTMLAnchorElement HTMLAreaElement HTMLAudioElement HTMLBaseElement HTMLBaseFontElement HTMLBodyElement HTMLBRElement HTMLButtonElement HTMLCanvasElement HTMLCollection HTMLDataElement HTMLDataListElement HTMLDivElement HTMLDListElement HTMLDocument HTMLElement HTMLEmbedElement HTMLFieldSetElement HTMLFormControlsCollection HTMLFormElement HTMLHeadElement HTMLHeadingElement HTMLHRElement HTMLHtmlElement HTMLIFrameElement HTMLImageElement HTMLInputElement HTMLIsIndexElement HTMLKeygenElement HTMLLabelElement HTMLLegendElement HTMLLIElement HTMLLinkElement HTMLMapElement HTMLMediaElement HTMLMetaElement HTMLMeterElement HTMLModElement HTMLObjectElement HTMLOListElement HTMLOptGroupElement HTMLOptionElement HTMLOptionsCollection HTMLOutputElement HTMLParagraphElement HTMLParamElement HTMLPreElement HTMLProgressElement HTMLQuoteElement HTMLScriptElement HTMLSelectElement HTMLSourceElement HTMLSpanElement HTMLStyleElement HTMLTableCaptionElement HTMLTableCellElement HTMLTableColElement HTMLTableElement HTMLTableRowElement HTMLTableSectionElement HTMLTextAreaElement HTMLTimeElement HTMLTitleElement HTMLTrackElement HTMLUListElement HTMLUnknownElement HTMLVideoElement
syntax keyword    javaScriptWebAPI                    IDBCursor IDBCursorWithValue IDBDatabase IDBDatabaseException IDBEnvironment IDBFactory IDBIndex IDBKeyRange IDBObjectStore IDBOpenDBRequest IDBRequest IDBTransaction IDBVersionChangeEvent ImageData Int16Array Int32Array Int8Array KeyboardEvent LinkStyle LocalFileSystem LocalFileSystemSync Location MediaQueryList MediaQueryListListener MediaSource MediaStream MediaStreamTrack MessageEvent MouseEvent MouseScrollEvent MouseWheelEvent MozActivity MozActivityOptions MozActivityRequestHandler MozAlarmsManager MozContact MozContactChangeEvent MozIccManager MozMmsEvent MozMmsMessage MozMobileCellInfo MozMobileCFInfo MozMobileConnection MozMobileConnectionInfo MozMobileICCInfo MozMobileMessageManager MozMobileMessageThread MozMobileNetworkInfo MozNetworkStats MozNetworkStatsData MozNetworkStatsManager MozSettingsEvent MozSmsEvent MozSmsFilter MozSmsManager MozSmsMessage MozSmsSegmentInfo MozTimeManager MozWifiConnectionInfoEvent MutationObserver
syntax keyword    javaScriptWebAPI                    NamedNodeMap NameList Navigator NavigatorGeolocation NavigatorID NavigatorLanguage NavigatorOnLine NavigatorPlugins NetworkInformation Node NodeFilter NodeIterator NodeList Notation Notification NotifyAudioAvailableEvent OfflineAudioCompletionEvent OfflineAudioContext PannerNode ParentNode Performance PerformanceNavigation PerformanceTiming Plugin PluginArray Position PositionError PositionOptions PowerManager ProcessingInstruction ProgressEvent Promise PromiseResolver PushManager
syntax keyword    javaScriptWebAPI                    Range ScriptProcessorNode Selection SettingsLock SettingsManager SharedWorker StyleSheet StyleSheetList SVGAElement SVGAngle SVGAnimateColorElement SVGAnimatedAngle SVGAnimatedBoolean SVGAnimatedEnumeration SVGAnimatedInteger SVGAnimatedLengthList SVGAnimatedNumber SVGAnimatedNumberList SVGAnimatedPoints SVGAnimatedPreserveAspectRatio SVGAnimatedRect SVGAnimatedString SVGAnimatedTransformList SVGAnimateElement SVGAnimateMotionElement SVGAnimateTransformElement SVGAnimationElement SVGCircleElement SVGClipPathElement SVGCursorElement SVGDefsElement SVGDescElement SVGElement SVGEllipseElement SVGFilterElement SVGFontElement SVGFontFaceElement SVGFontFaceFormatElement SVGFontFaceNameElement SVGFontFaceSrcElement SVGFontFaceUriElement
syntax keyword    javaScriptWebAPI                    SVGForeignObjectElement SVGGElement SVGGlyphElement SVGGradientElement SVGHKernElement SVGImageElement SVGLength SVGLengthList SVGLinearGradientElement SVGLineElement SVGMaskElement SVGMatrix SVGMissingGlyphElement SVGMPathElement SVGNumber SVGNumberList SVGPathElement SVGPatternElement SVGPolygonElement SVGPolylineElement SVGPreserveAspectRatio SVGRadialGradientElement SVGRect SVGRectElement SVGScriptElement SVGSetElement SVGStopElement SVGStringList SVGStylable SVGStyleElement SVGSVGElement SVGSwitchElement SVGSymbolElement SVGTests SVGTextElement SVGTextPositioningElement SVGTitleElement SVGTransform SVGTransformable SVGTransformList SVGTRefElement SVGTSpanElement SVGUseElement SVGViewElement SVGVKernElement TCPSocket Telephony TelephonyCall Text TextDecoder TextEncoder TextMetrics TimeRanges Touch TouchEvent TouchList Transferable TransitionEvent TreeWalker TypeInfo UIEvent Uint16Array Uint32Array Uint8Array Uint8ClampedArray URL URLUtils URLUtilsReadOnly

syntax match      javaScriptBraces                    "[{}\[\]]"
syntax match      javaScriptCommentSkip               "^[ \t]*\*\($\|[ \t]\+\)"
syntax match      javaScriptEndColons                 "[;,]"
syntax match      javaScriptFloat                     /\<-\=\%(\d\+\.\d\+\|\d\+\.\|\.\d\+\)\%([eE][+-]\=\d\+\)\=\>/
syntax match      javaScriptFuncArg                   "\(([^()]*)\)" contains=javaScriptParens,javaScriptFuncComma contained
syntax match      javaScriptFuncComma                 /,/ contained
syntax match      javaScriptFuncEq                    /=/ contained
syntax match      javaScriptLineComment               "\/\/.*" contains=@Spell,javaScriptCommentTodo
syntax match      javaScriptLogicSymbols              "\(&&\)\|\(||\)"
syntax match      javaScriptNumber                    "-\=\<\d\+L\=\>\|0[xX][0-9a-fA-F]\+\>"
syntax match      javaScriptOpSymbols                 "=\{1,3}\|!==\|!=\|<\|>\|>=\|<=\|++\|+=\|--\|-="
syntax match      javaScriptParens                    "[()]"
syntax match      javaScriptSpecial                   "\\\d\d\d\|\\."
syntax match      javaScriptSpecialCharacter          "'\\.'"

syntax region     javaScriptComment                   start="/\*"  end="\*/" contains=@Spell,javaScriptCommentTodo
syntax region     javaScriptFuncDef                   start="\<function\>" end="\([^)]*\)" contains=javaScriptFuncKeyword,javaScriptFuncArg keepend
syntax region     javaScriptFuncExp                   start=/\w\+\s\==\s\=function\>/ end="\([^)]*\)" contains=javaScriptFuncEq,javaScriptFuncKeyword,javaScriptFuncArg keepend
syntax region     javaScriptRegexpString              start=+/[^/*]+me=e-1 skip=+\\\\\|\\/+ end=+/[gim]\{0,2\}\s*$+ end=+/[gim]\{0,2\}\s*[;.,)\]}]+me=e-1 contains=@htmlPreproc oneline
syntax region     javaScriptString                    start=+'+  skip=+\\\\\|\\'+  end=+'\|$+	contains=javaScriptSpecial,@htmlPreproc

if exists("javascript_enable_domhtmlcss")
  syntax keyword  javaScriptCssStyles                 contained color font fontFamily fontSize fontSizeAdjust fontStretch fontStyle fontVariant fontWeight letterSpacing lineBreak lineHeight quotes rubyAlign rubyOverhang rubyPosition
  syntax keyword  javaScriptCssStyles                 contained textAlign textAlignLast textAutospace textDecoration textIndent textJustify textJustifyTrim textKashidaSpace textOverflowW6 textShadow textTransform textUnderlinePosition
  syntax keyword  javaScriptCssStyles                 contained unicodeBidi whiteSpace wordBreak wordSpacing wordWrap writingMode
  syntax keyword  javaScriptCssStyles                 contained bottom height left position right top width zIndex
  syntax keyword  javaScriptCssStyles                 contained border borderBottom borderLeft borderRight borderTop borderBottomColor borderLeftColor borderTopColor borderBottomStyle borderLeftStyle borderRightStyle borderTopStyle borderBottomWidth borderLeftWidth borderRightWidth borderTopWidth borderColor borderStyle borderWidth borderCollapse borderSpacing captionSide emptyCells tableLayout
  syntax keyword  javaScriptCssStyles                 contained margin marginBottom marginLeft marginRight marginTop outline outlineColor outlineStyle outlineWidth padding paddingBottom paddingLeft paddingRight paddingTop
  syntax keyword  javaScriptCssStyles                 contained listStyle listStyleImage listStylePosition listStyleType
  syntax keyword  javaScriptCssStyles                 contained background backgroundAttachment backgroundColor backgroundImage gackgroundPosition backgroundPositionX backgroundPositionY backgroundRepeat
  syntax keyword  javaScriptCssStyles                 contained clear clip clipBottom clipLeft clipRight clipTop content counterIncrement counterReset cssFloat cursor direction display filter layoutGrid layoutGridChar layoutGridLine layoutGridMode layoutGridType
  syntax keyword  javaScriptCssStyles                 contained marks maxHeight maxWidth minHeight minWidth opacity MozOpacity overflow overflowX overflowY verticalAlign visibility zoom cssText
  syntax keyword  javaScriptCssStyles                 contained scrollbar3dLightColor scrollbarArrowColor scrollbarBaseColor scrollbarDarkShadowColor scrollbarFaceColor scrollbarHighlightColor scrollbarShadowColor scrollbarTrackColor

  syntax match    javaScriptDomElemAttrs              contained /\%(nodeName\|nodeValue\|nodeType\|parentNode\|childNodes\|firstChild\|lastChild\|previousSibling\|nextSibling\|attributes\|ownerDocument\|namespaceURI\|prefix\|localName\|tagName\)\>/
  syntax match    javaScriptDomElemFuncs              contained /\%(insertBefore\|replaceChild\|removeChild\|appendChild\|hasChildNodes\|cloneNode\|normalize\|isSupported\|hasAttributes\|getAttribute\|setAttribute\|removeAttribute\|getAttributeNode\|setAttributeNode\|removeAttributeNode\|getElementsByTagName\|getAttributeNS\|setAttributeNS\|removeAttributeNS\|getAttributeNodeNS\|setAttributeNodeNS\|getElementsByTagNameNS\|hasAttribute\|hasAttributeNS\)\>/ nextgroup=javaScriptParen skipwhite
  syntax match    javaScriptDotNotation               "\." nextgroup=javaScriptPrototype,javaScriptDomElemAttrs,javaScriptDomElemFuncs,javaScriptHtmlElemAttrs,javaScriptHtmlElemFuncs
  syntax match    javaScriptDotNotation               "\.style\." nextgroup=javaScriptCssStyles
  syntax match    javaScriptHtmlElemAttrs             contained /\%(className\|clientHeight\|clientLeft\|clientTop\|clientWidth\|dir\|id\|innerHTML\|lang\|length\|offsetHeight\|offsetLeft\|offsetParent\|offsetTop\|offsetWidth\|scrollHeight\|scrollLeft\|scrollTop\|scrollWidth\|style\|tabIndex\|title\)\>/
  syntax match    javaScriptHtmlElemFuncs             contained /\%(blur\|click\|focus\|scrollIntoView\|addEventListener\|dispatchEvent\|removeEventListener\|item\)\>/ nextgroup=javaScriptParen skipwhite
endif


if main_syntax == "javascript"
  syntax sync clear
  syntax sync ccomment javaScriptComment minlines=200
endif

if !exists("did_javascript_syn_inits")
  command -nargs=+ HighlightDefLink highlight def link <args>

  HighlightDefLink javaScriptAjaxMethods              Type
  HighlightDefLink javaScriptAjaxObjects              Constant
  HighlightDefLink javaScriptAjaxProperties           Label
  HighlightDefLink javaScriptBoolean                  Boolean
  HighlightDefLink javaScriptBraces                   Function
  HighlightDefLink javaScriptBranch                   Conditional
  HighlightDefLink javaScriptBrowserObjects           Constant
  HighlightDefLink javaScriptCharacter                Character
  HighlightDefLink javaScriptComment                  Comment
  HighlightDefLink javaScriptCommentTodo              Todo
  HighlightDefLink javaScriptConditional              Conditional
  HighlightDefLink javaScriptCssStyles                Type
  HighlightDefLink javaScriptDeprecated               Exception
  HighlightDefLink javaScriptDocComment               Comment
  HighlightDefLink javaScriptDocParam                 Function
  HighlightDefLink javaScriptDocSeeTag                Function
  HighlightDefLink javaScriptDocTags                  Special
  HighlightDefLink javaScriptDomElemAttrs             Label
  HighlightDefLink javaScriptDomElemFuncs             Type
  HighlightDefLink javaScriptDomErrNo                 Error
  HighlightDefLink javaScriptDomMethods               Type
  HighlightDefLink javaScriptDomObjects               Constant
  HighlightDefLink javaScriptDomProperties            Label
  HighlightDefLink javaScriptDomNodeConsts            Constant
  HighlightDefLink javaScriptEndColons                Operator
  HighlightDefLink javaScriptError                    Error
  HighlightDefLink javaScriptEventListenerKeywords    Type
  HighlightDefLink javaScriptExceptions               Special
  HighlightDefLink javaScriptFloat                    Number
  HighlightDefLink javaScriptFuncArg                  Special
  HighlightDefLink javaScriptFuncComma                Operator
  HighlightDefLink javaScriptFuncDef                  PreProc
  HighlightDefLink javaScriptFuncEq                   Operator
  HighlightDefLink javaScriptFuncExp                  Title
  HighlightDefLink javaScriptFuncKeyword              Function
  HighlightDefLink javaScriptGlobal                   Constant
  HighlightDefLink javaScriptGlobalObjects            Special
  HighlightDefLink javaScriptHtmlElemAttrs            Label
  HighlightDefLink javaScriptHtmlElemFuncs            Type
  HighlightDefLink javaScriptHtmlElemProperties       Label
  HighlightDefLink javaScriptHtmlEvents               Constant
  HighlightDefLink javaScriptIdentifier               Identifier
  HighlightDefLink javaScriptLabel                    Label
  HighlightDefLink javaScriptLineComment              Comment
  HighlightDefLink javaScriptLogicSymbols             Boolean
  HighlightDefLink javaScriptMessage                  Keyword
  HighlightDefLink javaScriptNull                     Type
  HighlightDefLink javaScriptNumber                   Number
  HighlightDefLink javaScriptOperator                 Operator
  HighlightDefLink javaScriptOpSymbols                Operator
  HighlightDefLink javaScriptParens                   Operator
  HighlightDefLink javaScriptParensErrA               Error
  HighlightDefLink javaScriptParensErrB               Error
  HighlightDefLink javaScriptParensErrC               Error
  HighlightDefLink javaScriptParensError              Error
  HighlightDefLink javaScriptPropietaryObjects        Constant
  HighlightDefLink javaScriptPrototype                Type
  HighlightDefLink javaScriptRegexpString             String
  HighlightDefLink javaScriptRepeat                   Repeat
  HighlightDefLink javaScriptReserved                 Keyword
  HighlightDefLink javaScriptSource                   Special
  HighlightDefLink javaScriptSpecial                  Special
  HighlightDefLink javaScriptStatement                Statement
  HighlightDefLink javaScriptString                   String
  HighlightDefLink javaScriptWebAPI                   Type

  delcommand HighlightDefLink
endif

let b:current_syntax = "javascript"

if main_syntax == 'javascript'
  unlet main_syntax
endif

setlocal foldlevelstart=1
setlocal foldmethod=syntax

syntax region foldBraces start=/{/ end=/}/ transparent fold keepend extend

normal zR

