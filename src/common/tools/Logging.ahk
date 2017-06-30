class Logging {

    write(message, level, location="Unspecified", file=false) {

        FileAppend, % "[" A_YYYY "-" A_MM "-" A_DD " " A_Hour ":" A_Min ":" A_Sec "] [" location "] [" level "] " message "`n", % file

    }

}