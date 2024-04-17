module random_nfts::random_nfts {


    use sui::tx_context::{Self, TxContext};
    use sui::package::{Self, Publisher};
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::display::{Self, Display};
    use sui::event;
    use std::string::{utf8, String};

    #[test_only]
    friend random_nfts::random_nfts_tests;



    struct GnomeGeneral has key, store {
        id: UID,
        name: String, 
        image_url: String,
    }

    struct GnomeMonster has key, store {
        id: UID,
        name: String, 
        image_url: String,
    }

    struct GnomeRider has key, store {
        id: UID,
        name: String, 
        image_url: String,
    }

    struct GnomeSoldier has key, store {
        id: UID,
        name: String, 
        image_url: String,
    }







    struct CapyGeneral has key, store {
        id: UID,
        name: String, 
        image_url: String,
    }

    struct CapyMonster has key, store {
        id: UID,
        name: String, 
        image_url: String,
    }

    struct CapyRider has key, store {
        id: UID,
        name: String, 
        image_url: String,
    }

    struct CapySoldier has key, store {
        id: UID,
        name: String, 
        image_url: String,
    }






    struct RANDOM_NFTS has drop {}


    fun init(otw: RANDOM_NFTS, ctx: &mut TxContext) {


        // gnome general
        let gnome_general_keys = vector[
            utf8(b"name"),
            utf8(b"link"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];

        let gnome_general_values = vector[
            utf8(b""),
            utf8(b""),
            utf8(b""),
            utf8(b""),
            utf8(b""),
            utf8(b""),
        ];

        // gnome monster
        let gnome_monster_keys = vector[
            utf8(b"name"),
            utf8(b"link"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];

        let gnome_monster_values = vector[
            utf8(b""),
            utf8(b""),
            utf8(b""),
            utf8(b""),
            utf8(b""),
            utf8(b""),
        ];


        let publisher = package::claim(otw, ctx);


        // add gnome general
        let display_gnome_general = display::new_with_fields<GnomeGeneral>(
            &publisher, gnome_general_keys, gnome_general_values, ctx
        );

        display::update_version(&mut display_gnome_general);


        // add gnome monster
        let display_gnome_monster = display::new_with_fields<GnomeMonster>(
            &publisher, gnome_monster_keys, gnome_monster_values, ctx
        );

        display::update_version(&mut display_gnome_monster);




        // transfer publisher
        transfer::public_transfer(publisher, tx_context::sender(ctx));
        // transfer character displays
        transfer::public_transfer(display_gnome_general, tx_context::sender(ctx));
        transfer::public_transfer(display_gnome_monster, tx_context::sender(ctx));



    }




















    #[test_only]
    public fun init_for_testing(otw: RANDOM_NFTS, ctx: &mut TxContext) {
        init(otw, ctx);
    }





}