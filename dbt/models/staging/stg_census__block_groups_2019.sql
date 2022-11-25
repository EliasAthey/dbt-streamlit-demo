with source as (
    select
        *
    from
        {{source('census','2019_CBG_B01')}}
),
renamed as (
    select
        CENSUS_BLOCK_GROUP as block_group,
        "B01001e1",
        "B01001e10",
        "B01001e11",
        "B01001e12",
        "B01001e13",
        "B01001e14",
        "B01001e15",
        "B01001e16",
        "B01001e17",
        "B01001e18",
        "B01001e19",
        "B01001e2",
        "B01001e20",
        "B01001e21",
        "B01001e22",
        "B01001e23",
        "B01001e24",
        "B01001e25",
        "B01001e26",
        "B01001e27",
        "B01001e28",
        "B01001e29",
        "B01001e3",
        "B01001e30",
        "B01001e31",
        "B01001e32",
        "B01001e33",
        "B01001e34",
        "B01001e35",
        "B01001e36",
        "B01001e37",
        "B01001e38",
        "B01001e39",
        "B01001e4",
        "B01001e40",
        "B01001e41",
        "B01001e42",
        "B01001e43",
        "B01001e44",
        "B01001e45",
        "B01001e46",
        "B01001e47",
        "B01001e48",
        "B01001e49",
        "B01001e5",
        "B01001e6",
        "B01001e7",
        "B01001e8",
        "B01001e9",
        "B01001m1",
        "B01001m10",
        "B01001m11",
        "B01001m12",
        "B01001m13",
        "B01001m14",
        "B01001m15",
        "B01001m16",
        "B01001m17",
        "B01001m18",
        "B01001m19",
        "B01001m2",
        "B01001m20",
        "B01001m21",
        "B01001m22",
        "B01001m23",
        "B01001m24",
        "B01001m25",
        "B01001m26",
        "B01001m27",
        "B01001m28",
        "B01001m29",
        "B01001m3",
        "B01001m30",
        "B01001m31",
        "B01001m32",
        "B01001m33",
        "B01001m34",
        "B01001m35",
        "B01001m36",
        "B01001m37",
        "B01001m38",
        "B01001m39",
        "B01001m4",
        "B01001m40",
        "B01001m41",
        "B01001m42",
        "B01001m43",
        "B01001m44",
        "B01001m45",
        "B01001m46",
        "B01001m47",
        "B01001m48",
        "B01001m49",
        "B01001m5",
        "B01001m6",
        "B01001m7",
        "B01001m8",
        "B01001m9",
        "B01002Ae1",
        "B01002Ae2",
        "B01002Ae3",
        "B01002Am1",
        "B01002Am2",
        "B01002Am3",
        "B01002Be1",
        "B01002Be2",
        "B01002Be3",
        "B01002Bm1",
        "B01002Bm2",
        "B01002Bm3",
        "B01002Ce1",
        "B01002Ce2",
        "B01002Ce3",
        "B01002Cm1",
        "B01002Cm2",
        "B01002Cm3",
        "B01002De1",
        "B01002De2",
        "B01002De3",
        "B01002Dm1",
        "B01002Dm2",
        "B01002Dm3",
        "B01002e1",
        "B01002e2",
        "B01002e3",
        "B01002Ee1",
        "B01002Ee2",
        "B01002Ee3",
        "B01002Em1",
        "B01002Em2",
        "B01002Em3",
        "B01002Fe1",
        "B01002Fe2",
        "B01002Fe3",
        "B01002Fm1",
        "B01002Fm2",
        "B01002Fm3",
        "B01002Ge1",
        "B01002Ge2",
        "B01002Ge3",
        "B01002Gm1",
        "B01002Gm2",
        "B01002Gm3",
        "B01002He1",
        "B01002He2",
        "B01002He3",
        "B01002Hm1",
        "B01002Hm2",
        "B01002Hm3",
        "B01002Ie1",
        "B01002Ie2",
        "B01002Ie3",
        "B01002Im1",
        "B01002Im2",
        "B01002Im3",
        "B01002m1",
        "B01002m2",
        "B01002m3",
        "B01003e1",
        "B01003m1"
    from
        source
)
select * from renamed
