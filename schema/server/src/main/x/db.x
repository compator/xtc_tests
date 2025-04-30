@Database
module db {
    package oodb import oodb.xtclang.org;
    import oodb.*;

    // Below are 3 schemas. The first one is for reference and makes the app work fine.
    // The others are "broken". See the inline comments.
    // To test the different versions just comment the one change the one you want to test to "Schema"

    // ---------------------------------------------------------------------------------
    // This is a working version of the db schema for reference
    interface Schema
            extends oodb.RootSchema {

        @RO Strings strings;

        @RO DBCounter stringsKey;
    }

    mixin Strings
            into DBMap<Int, String> {
        @Synchronized
        String add(String v) {
            var k = dbCounterFor(/stringsKey).next();
            assert putIfAbsent(k, v);
            return v;
        }
    }

    // ---------------------------------------------------------------------------------
    // a problem with the mixin:
    interface Schema1
            extends oodb.RootSchema {

        @RO Strings1 strings;

        @RO DBCounter stringsKey;

        // what is wrong:
        // I have accidentally put the mixin inside the Schema. xcc will still compile it without complaining.
        // The application can be registered but fails when it is started.
        // I don't know if it is actually allowed to have the mixin inside the Schema. If not then I would
        // assume the Parser to pick up on this and the build should fail.
        mixin Strings1
                into DBMap<Int, String> {
            @Synchronized
            String add(String v) {
                var k = dbCounterFor(/stringsKey).next();
                assert putIfAbsent(k, v);
                return v;
            }
        }
    }

    // ---------------------------------------------------------------------------------
    // a problem with an incorrect reference:
    interface Schema2
            extends oodb.RootSchema {

        @RO Strings2 strings;

        @RO DBCounter stringsKey;
    }

    mixin Strings2
            into DBMap<Int, String> {
        @Synchronized
        String add(String v) {

            // what is wrong:
            // there is a typo in the /stringsKey -> /stringzKey
            // xcc will compile it and the module. I can upload it to the Platform and the application starts.
            // I would say xcc should pick up the unresolved dependency.
            var k = dbCounterFor(/stringzKey).next();
            assert putIfAbsent(k, v);
            return v;
        }
    }
}

