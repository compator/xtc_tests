@WebApp
module test {
    package db import db;
    import db.*;
    package web import web.xtclang.org;
    import web.*;

    @WebService("/api")
    service Test {
        @Inject db.Schema schema;
        @Post("add")
        @Produces(Text)
        String add(@BodyParam String str) {
            return schema.strings.add(str);
        }
    }

    @StaticContent("/", /public)
    service Content {}
}

