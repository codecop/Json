JsonTest := UnitTest clone do(

    testRoundTrip := method(
        x := Object clone
        x a := 1
        x b := 2
        x list := list(1,2,3,4)
        x t := true
        x f := false
        x n := nil
        x s := "seq"
        x o := Object clone do( x := 13; y := 19 )
        x m := Map clone atPut("x", 13) atPut("y", 19)
        x mut := "\"" asMutable
        x hex := 19 asCharacter # Doesn't work as the character is stripped out because Io doesn't support escaping.
        x jobj := JsonObject clone addSlot("setSlot", 13) addSlot("addSlot", "hehe")

        json := x asJson
        # writeln(json)
        expected := "{" .. \
            """"a":1, "b":2, "f":false, """ .. \
            "\"hex\":\"" .. (19 asCharacter) .. "\", " .. \
            """"jobj":{"addSlot":"hehe", "setSlot":13}, """ .. \
            """"list":[1, 2, 3, 4], """ .. \
            """"m":{"x":13, "y":19}, """ .. \
            """"mut":"\"", "n":null, """ .. \
            """"o":{"x":13, "y":19}, """ .. \
            """"s":"seq", "t":true""" .. \
            "}" # "
        assertEquals(expected, json)

        y := json parseJson
        # writeln(y asJson)
        assertEquals(y a, 1)
        assertEquals(y b, 2)
        assertEquals(y list, list(1,2,3,4))
        assertTrue(y t)
        assertFalse(y f)
        assertNil(y n)
        assertEquals(y s, "seq")
        assertEquals(y o x, 13)
        assertEquals(y o y, 19)
        assertEquals(y m at("x"), 13)
        assertEquals(y m at("y"), 19)
        assertEquals(y mut, "\"")
        assertEquals(y hex, 19 asCharacter)
        assertEquals(y jobj at("setSlot"), 13)
        assertEquals(y jobj at("addSlot"), "hehe")
    )

)
