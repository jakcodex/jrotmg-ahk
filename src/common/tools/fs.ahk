class filesystem {

    write(filename, contents) {

        if ( RegExMatch(filename, ".*?\..*$") ) {

            file := FileOpen(filename, "w")
            bytes := file.Write(contents)
            file.Close()
            return bytes

        } else {

            return false

        }

    }

}