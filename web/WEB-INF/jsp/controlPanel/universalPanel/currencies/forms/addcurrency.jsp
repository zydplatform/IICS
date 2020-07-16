<%-- 
    Document   : addcurrency
    Created on : May 31, 2018, 8:59:41 AM
    Author     : RESEARCH
--%>
<%@include file="../../../../include.jsp"%>

<div class="tile-body">
    <div class="row">
        <div class="col-md-12">
            <form class="form-horizontal">
                <div class="form-group row">
                    <label class="control-label">Search Country:</label>
                    <select class="form-control country_search" id="selectcountry">
                        <option value="">-----Search Country-----</option>
                    </select>
                </div>
                <div class="form-group row">
                    <label class="control-label col-md-4" for="description2">Currency Name</label>
                    <div class="col-md-8">
                        <input class="form-control" id="currencyname" name="currencynamez">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="control-label col-md-4" for="description2">Currency Abbrv.</label>
                    <div class="col-md-8">
                        <input class="form-control" id="currencyabbrv" name="currencyabbrvz">
                    </div>
                </div>

            </form>
        </div>
    </div>
</div>
<div class="tile-footer">
    <button class="btn btn-primary" id="saveCountrycurrency" type="button"><i class="fa fa-fw fa-lg fa-check-circle"></i>Save Currency</button>
    <button class="btn btn-secondary" type="button" data-dismiss="modal">Close</button>
</div>
<script>
    var currencies = [
        {
            country: "ÅLAND ISLANDS",
            currency: "Euro",
            abb: "EUR"
        },
        {
            country: "ALBANIA",
            currency: "Lek",
            abb: "ALL"
        },
        {
            country: "ALGERIA",
            currency: "Algerian Dinar",
            abb: "DZD"
        },
        {
            country: "AMERICAN SAMOA",
            currency: "US Dollar",
            abb: "USD"
        },
        {
            country: "ANDORRA",
            currency: "Euro",
            abb: "EUR"
        },
        {
            country: "ANGOLA",
            currency: "Kwanza",
            abb: "AOA"
        },
        {
            country: "ANGUILLA",
            currency: "East Caribbean Dollar",
            abb: "XCD"
        },
        {
            country: "ANTARCTICA",
            currency: "No universal currency",
            abb: ""
        },
        {
            country: "ANTIGUA AND BARBUDA",
            currency: "East Caribbean Dollar",
            abb: "XCD"
        },
        {
            country: "ARGENTINA",
            currency: "Argentine Peso",
            abb: "ARS"
        },
        {
            country: "ARMENIA",
            currency: "Armenian Dram",
            abb: "AMD"
        },
        {
            country: "ARUBA",
            currency: "Aruban Florin",
            abb: "AWG"
        },
        {
            country: "AUSTRALIA",
            currency: "Australian Dollar",
            abb: "AUD"
        },
        {
            country: "AUSTRIA",
            currency: "Euro",
            abb: "EUR"
        },
        {
            country: "AZERBAIJAN",
            currency: "Azerbaijanian Manat",
            abb: "AZN"
        },
        {
            country: "BAHAMAS (THE)",
            currency: "Bahamian Dollar",
            abb: "BSD"
        },
        {
            country: "BAHRAIN",
            currency: "Bahraini Dinar",
            abb: "BHD"
        },
        {
            country: "BANGLADESH",
            currency: "Taka",
            abb: "BDT"
        },
        {
            country: "BARBADOS",
            currency: "Barbados Dollar",
            abb: "BBD"
        },
        {
            country: "BELARUS",
            currency: "Belarussian Ruble",
            abb: "BYR"
        },
        {
            country: "BELGIUM",
            currency: "Euro",
            abb: "EUR"
        },
        {
            country: "BELIZE",
            currency: "Belize Dollar",
            abb: "BZD"
        },
        {
            country: "BENIN",
            currency: "CFA Franc BCEAO",
            abb: "XOF"
        },
        {
            country: "BERMUDA",
            currency: "Bermudian Dollar",
            abb: "BMD"
        },
        {
            country: "BHUTAN",
            currency: "Ngultrum",
            abb: "BTN"
        },
        {
            country: "BOLIVIA (PLURINATIONAL STATE OF)",
            currency: "Boliviano",
            abb: "BOB"
        },
        {
            country: "BONAIRE",
            currency: " SINT EUSTATIUS AND SABA",
            abb: "US Dollar"
        },
        {
            country: "BOSNIA AND HERZEGOVINA",
            currency: "Convertible Mark",
            abb: "BAM"
        },
        {
            country: "BOTSWANA",
            currency: "Pula",
            abb: "BWP"
        },
        {
            country: "BOUVET ISLAND",
            currency: "Norwegian Krone",
            abb: "NOK"
        },
        {
            country: "BRAZIL",
            currency: "Brazilian Real",
            abb: "BRL"
        },
        {
            country: "BRITISH INDIAN OCEAN TERRITORY",
            currency: "US Dollar",
            abb: "USD"
        },
        {
            country: "BRUNEI DARUSSALAM",
            currency: "Brunei Dollar",
            abb: "BND"
        },
        {
            country: "BULGARIA",
            currency: "Bulgarian Lev",
            abb: "BGN"
        },
        {
            country: "BURKINA FASO",
            currency: "CFA Franc BCEAO",
            abb: "XOF"
        },
        {
            country: "BURUNDI",
            currency: "Burundi Franc",
            abb: "BIF"
        },
        {
            country: "CABO VERDE",
            currency: "Cabo Verde Escudo",
            abb: "CVE"
        },
        {
            country: "CAMBODIA",
            currency: "Riel",
            abb: "KHR"
        },
        {
            country: "CAMEROON",
            currency: "CFA Franc BEAC",
            abb: "XAF"
        },
        {
            country: "CANADA",
            currency: "Canadian Dollar",
            abb: "CAD"
        },
        {
            country: "CAYMAN ISLANDS",
            currency: "Cayman Islands Dollar",
            abb: "KYD"
        },
        {
            country: "CENTRAL AFRICAN REPUBLIC",
            currency: "CFA Franc BEAC",
            abb: "XAF"
        },
        {
            country: "CHAD",
            currency: "CFA Franc BEAC",
            abb: "XAF"
        },
        {
            country: "CHILE",
            currency: "Chilean Peso",
            abb: "CLP"
        },
        {
            country: "CHINA",
            currency: "Yuan Renminbi",
            abb: "CNY"
        },
        {
            country: "CHRISTMAS ISLAND",
            currency: "Australian Dollar",
            abb: "AUD"
        },
        {
            country: "COCOS (KEELING) ISLANDS",
            currency: "Australian Dollar",
            abb: "AUD"
        },
        {
            country: "COLOMBIA",
            currency: "Colombian Peso",
            abb: "COP"
        },
        {
            country: "COMOROS",
            currency: "Comoro Franc",
            abb: "KMF"
        },
        {
            country: "CONGO (THE DEMOCRATIC REPUBLIC OF CONGO)",
            currency: "Congolese Franc",
            abb: "CDF"
        },
        {
            country: "CONGO",
            currency: "CFA Franc BEAC",
            abb: "XAF"
        },
        {
            country: "COOK ISLANDS",
            currency: "New Zealand Dollar",
            abb: "NZD"
        },
        {
            country: "COSTA RICA",
            currency: "Costa Rican Colon",
            abb: "CRC"
        },
        {
            country: "CÔTE D'IVOIRE",
            currency: "CFA Franc BCEAO",
            abb: "XOF"
        },
        {
            country: "CROATIA",
            currency: "Kuna",
            abb: "HRK"
        },
        {
            country: "CUBA",
            currency: "Peso Convertible",
            abb: "CUC"
        },
        {
            country: "CUBA",
            currency: "Cuban Peso",
            abb: "CUP"
        },
        {
            country: "CURAÇAO",
            currency: "Netherlands Antillean Guilder",
            abb: "ANG"
        },
        {
            country: "CYPRUS",
            currency: "Euro",
            abb: "EUR"
        },
        {
            country: "CZECH REPUBLIC",
            currency: "Czech Koruna",
            abb: "CZK"
        },
        {
            country: "DENMARK",
            currency: "Danish Krone",
            abb: "DKK"
        },
        {
            country: "DJIBOUTI",
            currency: "Djibouti Franc",
            abb: "DJF"
        },
        {
            country: "DOMINICA",
            currency: "East Caribbean Dollar",
            abb: "XCD"
        },
        {
            country: "DOMINICAN REPUBLIC",
            currency: "Dominican Peso",
            abb: "DOP"
        },
        {
            country: "ECUADOR",
            currency: "US Dollar",
            abb: "USD"
        },
        {
            country: "EGYPT",
            currency: "Egyptian Pound",
            abb: "EGP"
        },
        {
            country: "EL SALVADOR",
            currency: "El Salvador Colon",
            abb: "SVC"
        },
        {
            country: "EL SALVADOR",
            currency: "US Dollar",
            abb: "USD"
        },
        {
            country: "EQUATORIAL GUINEA",
            currency: "CFA Franc BEAC",
            abb: "XAF"
        },
        {
            country: "ERITREA",
            currency: "Nakfa",
            abb: "ERN"
        },
        {
            country: "ESTONIA",
            currency: "Euro",
            abb: "EUR"
        },
        {
            country: "ETHIOPIA",
            currency: "Ethiopian Birr",
            abb: "ETB"
        },
        {
            country: "EUROPEAN UNION",
            currency: "Euro",
            abb: "EUR"
        },
        {
            country: "FALKLAND ISLANDS [MALVINAS]",
            currency: "Falkland Islands Pound",
            abb: "FKP"
        },
        {
            country: "FAROE ISLANDS",
            currency: "Danish Krone",
            abb: "DKK"
        },
        {
            country: "FIJI",
            currency: "Fiji Dollar",
            abb: "FJD"
        },
        {
            country: "FINLAND",
            currency: "Euro",
            abb: "EUR"
        },
        {
            country: "FRANCE",
            currency: "Euro",
            abb: "EUR"
        },
        {
            country: "FRENCH GUIANA",
            currency: "Euro",
            abb: "EUR"
        },
        {
            country: "FRENCH POLYNESIA",
            currency: "CFP Franc",
            abb: "XPF"
        },
        {
            country: "FRENCH SOUTHERN TERRITORIES",
            currency: "Euro",
            abb: "EUR"
        },
        {
            country: "GABON",
            currency: "CFA Franc BEAC",
            abb: "XAF"
        },
        {
            country: "GAMBIA",
            currency: "Dalasi",
            abb: "GMD"
        },
        {
            country: "GEORGIA",
            currency: "Lari",
            abb: "GEL"
        },
        {
            country: "GERMANY",
            currency: "Euro",
            abb: "EUR"
        },
        {
            country: "GHANA",
            currency: "Ghana Cedi",
            abb: "GHS"
        },
        {
            country: "GIBRALTAR",
            currency: "Gibraltar Pound",
            abb: "GIP"
        },
        {
            country: "GREECE",
            currency: "Euro",
            abb: "EUR"
        },
        {
            country: "GREENLAND",
            currency: "Danish Krone",
            abb: "DKK"
        },
        {
            country: "GRENADA",
            currency: "East Caribbean Dollar",
            abb: "XCD"
        },
        {
            country: "GUADELOUPE",
            currency: "Euro",
            abb: "EUR"
        },
        {
            country: "GUAM",
            currency: "US Dollar",
            abb: "USD"
        },
        {
            country: "GUATEMALA",
            currency: "Quetzal",
            abb: "GTQ"
        },
        {
            country: "GUERNSEY",
            currency: "Pound Sterling",
            abb: "GBP"
        },
        {
            country: "GUINEA",
            currency: "Guinea Franc",
            abb: "GNF"
        },
        {
            country: "GUINEA-BISSAU",
            currency: "CFA Franc BCEAO",
            abb: "XOF"
        },
        {
            country: "GUYANA",
            currency: "Guyana Dollar",
            abb: "GYD"
        },
        {
            country: "HAITI",
            currency: "Gourde",
            abb: "HTG"
        },
        {
            country: "HAITI",
            currency: "US Dollar",
            abb: "USD"
        },
        {
            country: "HEARD ISLAND AND McDONALD ISLANDS",
            currency: "Australian Dollar",
            abb: "AUD"
        },
        {
            country: "HOLY SEE",
            currency: "Euro",
            abb: "EUR"
        },
        {
            country: "HONDURAS",
            currency: "Lempira",
            abb: "HNL"
        },
        {
            country: "HONG KONG",
            currency: "Hong Kong Dollar",
            abb: "HKD"
        },
        {
            country: "HUNGARY",
            currency: "Forint",
            abb: "HUF"
        },
        {
            country: "ICELAND",
            currency: "Iceland Krona",
            abb: "ISK"
        },
        {
            country: "INDIA",
            currency: "Indian Rupee",
            abb: "INR"
        },
        {
            country: "INDONESIA",
            currency: "Rupiah",
            abb: "IDR"
        },
        {
            country: "INTERNATIONAL MONETARY FUND (IMF) ",
            currency: "SDR (Special Drawing Right)",
            abb: "XDR"
        },
        {
            country: "IRAN (ISLAMIC REPUBLIC OF)",
            currency: "Iranian Rial",
            abb: "IRR"
        },
        {
            country: "IRAQ",
            currency: "Iraqi Dinar",
            abb: "IQD"
        },
        {
            country: "IRELAND",
            currency: "Euro",
            abb: "EUR"
        },
        {
            country: "ISLE OF MAN",
            currency: "Pound Sterling",
            abb: "GBP"
        },
        {
            country: "ISRAEL",
            currency: "New Israeli Sheqel",
            abb: "ILS"
        },
        {
            country: "ITALY",
            currency: "Euro",
            abb: "EUR"
        },
        {
            country: "JAMAICA",
            currency: "Jamaican Dollar",
            abb: "JMD"
        },
        {
            country: "JAPAN",
            currency: "Yen",
            abb: "JPY"
        },
        {
            country: "JERSEY",
            currency: "Pound Sterling",
            abb: "GBP"
        },
        {
            country: "JORDAN",
            currency: "Jordanian Dinar",
            abb: "JOD"
        },
        {
            country: "KAZAKHSTAN",
            currency: "Tenge",
            abb: "KZT"
        },
        {
            country: "KENYA",
            currency: "Kenyan Shilling",
            abb: "KES"
        },
        {
            country: "KIRIBATI",
            currency: "Australian Dollar",
            abb: "AUD"
        },
        {
            country: "KOREA (THE DEMOCRATIC PEOPLE?S REPUBLIC OF)",
            currency: "North Korean Won",
            abb: "KPW"
        },
        {
            country: "KOREA (THE REPUBLIC OF)",
            currency: "Won",
            abb: "KRW"
        },
        {
            country: "KUWAIT",
            currency: "Kuwaiti Dinar",
            abb: "KWD"
        },
        {
            country: "KYRGYZSTAN",
            currency: "Som",
            abb: "KGS"
        },
        {
            country: "LAO PEOPLE?S DEMOCRATIC REPUBLIC",
            currency: "Kip",
            abb: "LAK"
        },
        {
            country: "LATVIA",
            currency: "Euro",
            abb: "EUR"
        },
        {
            country: "LEBANON",
            currency: "Lebanese Pound",
            abb: "LBP"
        },
        {
            country: "LESOTHO",
            currency: "Loti",
            abb: "LSL"
        },
        {
            country: "LESOTHO",
            currency: "Rand",
            abb: "ZAR"
        },
        {
            country: "LIBERIA",
            currency: "Liberian Dollar",
            abb: "LRD"
        },
        {
            country: "LIBYA",
            currency: "Libyan Dinar",
            abb: "LYD"
        },
        {
            country: "LIECHTENSTEIN",
            currency: "Swiss Franc",
            abb: "CHF"
        },
        {
            country: "LITHUANIA",
            currency: "Euro",
            abb: "EUR"
        },
        {
            country: "LUXEMBOURG",
            currency: "Euro",
            abb: "EUR"
        },
        {
            country: "MACAO",
            currency: "Pataca",
            abb: "MOP"
        },
        {
            country: "MACEDONIA (THE FORMER YUGOSLAV REPUBLIC OF)",
            currency: "Denar",
            abb: "MKD"
        },
        {
            country: "MADAGASCAR",
            currency: "Malagasy Ariary",
            abb: "MGA"
        },
        {
            country: "MALAWI",
            currency: "Kwacha",
            abb: "MWK"
        },
        {
            country: "MALAYSIA",
            currency: "Malaysian Ringgit",
            abb: "MYR"
        },
        {
            country: "MALDIVES",
            currency: "Rufiyaa",
            abb: "MVR"
        },
        {
            country: "MALI",
            currency: "CFA Franc BCEAO",
            abb: "XOF"
        },
        {
            country: "MALTA",
            currency: "Euro",
            abb: "EUR"
        },
        {
            country: "MARSHALL ISLANDS",
            currency: "US Dollar",
            abb: "USD"
        },
        {
            country: "MARTINIQUE",
            currency: "Euro",
            abb: "EUR"
        },
        {
            country: "MAURITANIA",
            currency: "Ouguiya",
            abb: "MRU"
        },
        {
            country: "MAURITIUS",
            currency: "Mauritius Rupee",
            abb: "MUR"
        },
        {
            country: "MAYOTTE",
            currency: "Euro",
            abb: "EUR"
        },
        {
            country: "MEMBER COUNTRIES OF THE AFRICAN DEVELOPMENT BANK GROUP",
            currency: "ADB Unit of Account",
            abb: "XUA"
        },
        {
            country: "MEXICO",
            currency: "Mexican Peso",
            abb: "MXN"
        },
        {
            country: "MEXICO",
            currency: "Mexican Unidad de Inversion (UDI)",
            abb: "MXV"
        },
        {
            country: "MICRONESIA (FEDERATED STATES OF)",
            currency: "US Dollar",
            abb: "USD"
        },
        {
            country: "MOLDOVA (THE REPUBLIC OF)",
            currency: "Moldovan Leu",
            abb: "MDL"
        },
        {
            country: "MONACO",
            currency: "Euro",
            abb: "EUR"
        },
        {
            country: "MONGOLIA",
            currency: "Tugrik",
            abb: "MNT"
        },
        {
            country: "MONTENEGRO",
            currency: "Euro",
            abb: "EUR"
        },
        {
            country: "MONTSERRAT",
            currency: "East Caribbean Dollar",
            abb: "XCD"
        },
        {
            country: "MOROCCO",
            currency: "Moroccan Dirham",
            abb: "MAD"
        },
        {
            country: "MOZAMBIQUE",
            currency: "Mozambique Metical",
            abb: "MZN"
        },
        {
            country: "MYANMAR",
            currency: "Kyat",
            abb: "MMK"
        },
        {
            country: "NAMIBIA",
            currency: "Namibia Dollar",
            abb: "NAD"
        },
        {
            country: "NAMIBIA",
            currency: "Rand",
            abb: "ZAR"
        },
        {
            country: "NAURU",
            currency: "Australian Dollar",
            abb: "AUD"
        },
        {
            country: "NEPAL",
            currency: "Nepalese Rupee",
            abb: "NPR"
        },
        {
            country: "NETHERLANDS",
            currency: "Euro",
            abb: "EUR"
        },
        {
            country: "NEW CALEDONIA",
            currency: "CFP Franc",
            abb: "XPF"
        },
        {
            country: "NEW ZEALAND",
            currency: "New Zealand Dollar",
            abb: "NZD"
        },
        {
            country: "NICARAGUA",
            currency: "Cordoba Oro",
            abb: "NIO"
        },
        {
            country: "NIGER",
            currency: "CFA Franc BCEAO",
            abb: "XOF"
        },
        {
            country: "NIGERIA",
            currency: "Naira",
            abb: "NGN"
        },
        {
            country: "NIUE",
            currency: "New Zealand Dollar",
            abb: "NZD"
        },
        {
            country: "NORFOLK ISLAND",
            currency: "Australian Dollar",
            abb: "AUD"
        },
        {
            country: "NORTHERN MARIANA ISLANDS",
            currency: "US Dollar",
            abb: "USD"
        },
        {
            country: "NORWAY",
            currency: "Norwegian Krone",
            abb: "NOK"
        },
        {
            country: "OMAN",
            currency: "Rial Omani",
            abb: "OMR"
        },
        {
            country: "PAKISTAN",
            currency: "Pakistan Rupee",
            abb: "PKR"
        },
        {
            country: "PALAU",
            currency: "US Dollar",
            abb: "USD"
        },
        {
            country: "PALESTINE",
            currency: " STATE OF",
            abb: "No universal currency"
        },
        {
            country: "PANAMA",
            currency: "Balboa",
            abb: "PAB"
        },
        {
            country: "PANAMA",
            currency: "US Dollar",
            abb: "USD"
        },
        {
            country: "PAPUA NEW GUINEA",
            currency: "Kina",
            abb: "PGK"
        },
        {
            country: "PARAGUAY",
            currency: "Guarani",
            abb: "PYG"
        },
        {
            country: "PERU",
            currency: "Nuevo Sol",
            abb: "PEN"
        },
        {
            country: "PHILIPPINES",
            currency: "Philippine Peso",
            abb: "PHP"
        },
        {
            country: "PITCAIRN",
            currency: "New Zealand Dollar",
            abb: "NZD"
        },
        {
            country: "POLAND",
            currency: "Zloty",
            abb: "PLN"
        },
        {
            country: "PORTUGAL",
            currency: "Euro",
            abb: "EUR"
        },
        {
            country: "PUERTO RICO",
            currency: "US Dollar",
            abb: "USD"
        },
        {
            country: "QATAR",
            currency: "Qatari Rial",
            abb: "QAR"
        },
        {
            country: "RÉUNION",
            currency: "Euro",
            abb: "EUR"
        },
        {
            country: "ROMANIA",
            currency: "Romanian Leu",
            abb: "RON"
        },
        {
            country: "RUSSIAN FEDERATION",
            currency: "Russian Ruble",
            abb: "RUB"
        },
        {
            country: "RWANDA",
            currency: "Rwanda Franc",
            abb: "RWF"
        },
        {
            country: "SAINT BARTHÉLEMY",
            currency: "Euro",
            abb: "EUR"
        },
        {
            country: "SAINT HELENA",
            currency: " ASCENSION AND TRISTAN DA CUNHA",
            abb: "Saint Helena Pound"
        },
        {
            country: "SAINT KITTS AND NEVIS",
            currency: "East Caribbean Dollar",
            abb: "XCD"
        },
        {
            country: "SAINT LUCIA",
            currency: "East Caribbean Dollar",
            abb: "XCD"
        },
        {
            country: "SAINT MARTIN (FRENCH PART)",
            currency: "Euro",
            abb: "EUR"
        },
        {
            country: "SAINT PIERRE AND MIQUELON",
            currency: "Euro",
            abb: "EUR"
        },
        {
            country: "SAINT VINCENT AND THE GRENADINES",
            currency: "East Caribbean Dollar",
            abb: "XCD"
        },
        {
            country: "SAMOA",
            currency: "Tala",
            abb: "WST"
        },
        {
            country: "SAN MARINO",
            currency: "Euro",
            abb: "EUR"
        },
        {
            country: "SAO TOME AND PRINCIPE",
            currency: "Dobra",
            abb: "STN"
        },
        {
            country: "SAUDI ARABIA",
            currency: "Saudi Riyal",
            abb: "SAR"
        },
        {
            country: "SENEGAL",
            currency: "CFA Franc BCEAO",
            abb: "XOF"
        },
        {
            country: "SERBIA",
            currency: "Serbian Dinar",
            abb: "RSD"
        },
        {
            country: "SEYCHELLES",
            currency: "Seychelles Rupee",
            abb: "SCR"
        },
        {
            country: "SIERRA LEONE",
            currency: "Leone",
            abb: "SLL"
        },
        {
            country: "SINGAPORE",
            currency: "Singapore Dollar",
            abb: "SGD"
        },
        {
            country: "SINT MAARTEN (DUTCH PART)",
            currency: "Netherlands Antillean Guilder",
            abb: "ANG"
        },
        {
            country: "SISTEMA UNITARIO DE COMPENSACION REGIONAL DE PAGOS ",
            currency: "Sucre",
            abb: "XSU"
        },
        {
            country: "SLOVAKIA",
            currency: "Euro",
            abb: "EUR"
        },
        {
            country: "SLOVENIA",
            currency: "Euro",
            abb: "EUR"
        },
        {
            country: "SOLOMON ISLANDS",
            currency: "Solomon Islands Dollar",
            abb: "SBD"
        },
        {
            country: "SOMALIA",
            currency: "Somali Shilling",
            abb: "SOS"
        },
        {
            country: "SOUTH AFRICA",
            currency: "Rand",
            abb: "ZAR"
        },
        {
            country: "SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS",
            currency: "No universal currency",
            abb: ""
        },
        {
            country: "SOUTH SUDAN",
            currency: "South Sudanese Pound",
            abb: "SSP"
        },
        {
            country: "SPAIN",
            currency: "Euro",
            abb: "EUR"
        },
        {
            country: "SRI LANKA",
            currency: "Sri Lanka Rupee",
            abb: "LKR"
        },
        {
            country: "SUDAN",
            currency: "Sudanese Pound",
            abb: "SDG"
        },
        {
            country: "SURINAME",
            currency: "Surinam Dollar",
            abb: "SRD"
        },
        {
            country: "SVALBARD AND JAN MAYEN",
            currency: "Norwegian Krone",
            abb: "NOK"
        },
        {
            country: "SWAZILAND",
            currency: "Lilangeni",
            abb: "SZL"
        },
        {
            country: "SWEDEN",
            currency: "Swedish Krona",
            abb: "SEK"
        },
        {
            country: "SWITZERLAND",
            currency: "WIR Euro",
            abb: "CHE"
        },
        {
            country: "SWITZERLAND",
            currency: "Swiss Franc",
            abb: "CHF"
        },
        {
            country: "SWITZERLAND",
            currency: "WIR Franc",
            abb: "CHW"
        },
        {
            country: "SYRIAN ARAB REPUBLIC",
            currency: "Syrian Pound",
            abb: "SYP"
        },
        {
            country: "TAIWAN (PROVINCE OF CHINA)",
            currency: "New Taiwan Dollar",
            abb: "TWD"
        },
        {
            country: "TAJIKISTAN",
            currency: "Somoni",
            abb: "TJS"
        },
        {
            country: "TANZANIA",
            currency: " UNITED REPUBLIC OF",
            abb: "Tanzanian Shilling"
        },
        {
            country: "THAILAND",
            currency: "Baht",
            abb: "THB"
        },
        {
            country: "TIMOR-LESTE",
            currency: "US Dollar",
            abb: "USD"
        },
        {
            country: "TOGO",
            currency: "CFA Franc BCEAO",
            abb: "XOF"
        },
        {
            country: "TOKELAU",
            currency: "New Zealand Dollar",
            abb: "NZD"
        },
        {
            country: "TONGA",
            currency: "Pa?anga",
            abb: "TOP"
        },
        {
            country: "TRINIDAD AND TOBAGO",
            currency: "Trinidad and Tobago Dollar",
            abb: "TTD"
        },
        {
            country: "TUNISIA",
            currency: "Tunisian Dinar",
            abb: "TND"
        },
        {
            country: "TURKEY",
            currency: "Turkish Lira",
            abb: "TRY"
        },
        {
            country: "TURKMENISTAN",
            currency: "Turkmenistan New Manat",
            abb: "TMT"
        },
        {
            country: "TURKS AND CAICOS ISLANDS",
            currency: "US Dollar",
            abb: "USD"
        },
        {
            country: "TUVALU",
            currency: "Australian Dollar",
            abb: "AUD"
        },
        {
            country: "UGANDA",
            currency: "Uganda Shilling",
            abb: "UGX"
        },
        {
            country: "UKRAINE",
            currency: "Hryvnia",
            abb: "UAH"
        },
        {
            country: "UNITED ARAB EMIRATES",
            currency: "UAE Dirham",
            abb: "AED"
        },
        {
            country: "UNITED KINGDOM OF GREAT BRITAIN AND NORTHERN IRELAND",
            currency: "Pound Sterling",
            abb: "GBP"
        },
        {
            country: "UNITED STATES MINOR OUTLYING ISLANDS",
            currency: "US Dollar",
            abb: "USD"
        },
        {
            country: "UNITED STATES OF AMERICA",
            currency: "US Dollar",
            abb: "USD"
        },
        {
            country: "URUGUAY",
            currency: "Uruguay Peso en Unidades Indexadas (URUIURUI)",
            abb: "UYI"
        },
        {
            country: "URUGUAY",
            currency: "Peso Uruguayo",
            abb: "UYU"
        },
        {
            country: "UZBEKISTAN",
            currency: "Uzbekistan Sum",
            abb: "UZS"
        },
        {
            country: "VANUATU",
            currency: "Vatu",
            abb: "VUV"
        },
        {
            country: "VENEZUELA (BOLIVARIAN REPUBLIC OF)",
            currency: "Bolivar",
            abb: "VEF"
        },
        {
            country: "VIET NAM",
            currency: "Dong",
            abb: "VND"
        },
        {
            country: "VIRGIN ISLANDS (BRITISH)",
            currency: "US Dollar",
            abb: "USD"
        },
        {
            country: "VIRGIN ISLANDS (U.S.)",
            currency: "US Dollar",
            abb: "USD"
        },
        {
            country: "WALLIS AND FUTUNA",
            currency: "CFP Franc",
            abb: "XPF"
        },
        {
            country: "WESTERN SAHARA",
            currency: "Moroccan Dirham",
            abb: "MAD"
        },
        {
            country: "YEMEN",
            currency: "Yemeni Rial",
            abb: "YER"
        },
        {
            country: "ZAMBIA",
            currency: "Zambian Kwacha",
            abb: "ZMW"
        },
        {
            country: "ZIMBABWE",
            currency: "Zimbabwe Dollar",
            abb: "ZWL"
        }
    ];
    for (i in currencies) {
        $('#selectcountry').append('<option value="' + currencies[i].country + '">' + currencies[i].country + '</option>')
    }
    $('.country_search').select2();
    $('.select2').css('width', '100%');


    $('#selectcountry').change(function () {
        for (i in currencies) {
            if (currencies[i].country === $('#selectcountry').val()) {
                $('#currencyname').val(currencies[i].currency);
                $('#currencyabbrv').val(currencies[i].abb);

            }
        }

    });

    $('#saveCountrycurrency').click(function () {
        var countryname = $("#selectcountry").val();
        var currencyname = $("#currencyname").val();
        var currencyabbreviation = $("#currencyabbrv").val();

        $.confirm({
            title: 'Message!',
            content: 'Save Currency' + ' ' + currencyname + ' ' + 'Currency Code' + ' ' + currencyabbreviation,
            type: 'red',
            typeAnimated: true,
            buttons: {
                tryAgain: {
                    text: 'Yes',
                    btnClass: 'btn-green',
                    action: function () {
                        $('.close').click();
                        $.ajax({
                            type: 'POST',
                            cache: false,
                            dataType: 'text',
                            data: {countryname: countryname, currencyname: currencyname, currencyabbreviation: currencyabbreviation},
                            url: "currencysystemsettings/savecurrencies.htm",
                            success: function (data) {
                                
                                ajaxSubmitData('currencysystemsettings/currencypane.htm', 'workpane', '', 'GET');
                            }
                        });
                    }
                },
                cancel: function () {
                    $('#addcurrency').modal('hide');
                    $('.body').removeClass('modal-open');
                    $('.modal-backdrop').remove();
                    $('.close').click();
                    ajaxSubmitData('currencysystemsettings/currencypane.htm', 'workpane', '', 'GET');
                }
            }
        });

    });

</script>