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
            utf8(b"{name}"),
            utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"capy vs. gnome"),
            utf8(b"https://capy-vs-gnome.xyz"),
            utf8(b"unk"),
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
            utf8(b"{name}"),
            utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"capy vs. gnome"),
            utf8(b"https://capy-vs-gnome.xyz"),
            utf8(b"unk"),
        ];

        // gnome rider
        let gnome_rider_keys = vector[
            utf8(b"name"),
            utf8(b"link"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];

        let gnome_rider_values = vector[
            utf8(b"{name}"),
            utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"capy vs. gnome"),
            utf8(b"https://capy-vs-gnome.xyz"),
            utf8(b"unk"),
        ];

        // gnome rider
        let gnome_soldier_keys = vector[
            utf8(b"name"),
            utf8(b"link"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];

        let gnome_soldier_values = vector[
            utf8(b"{name}"),
            utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"capy vs. gnome"),
            utf8(b"https://capy-vs-gnome.xyz"),
            utf8(b"unk"),
        ];



        // capy characters
        // capy general
        let capy_general_keys = vector[
            utf8(b"name"),
            utf8(b"link"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];

        let capy_general_values = vector[
            utf8(b"{name}"),
            utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"capy vs. gnome"),
            utf8(b"https://capy-vs-gnome.xyz"),
            utf8(b"unk"),
        ];

        // capy monster
        let capy_monster_keys = vector[
            utf8(b"name"),
            utf8(b"link"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];

        let capy_monster_values = vector[
            utf8(b"{name}"),
            utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"capy vs. gnome"),
            utf8(b"https://capy-vs-gnome.xyz"),
            utf8(b"unk"),
        ];

        // capy rider
        let capy_rider_keys = vector[
            utf8(b"name"),
            utf8(b"link"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];

        let capy_rider_values = vector[
            utf8(b"{name}"),
            utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"capy vs. gnome"),
            utf8(b"https://capy-vs-gnome.xyz"),
            utf8(b"unk"),
        ];

        // capy soldier
        let capy_soldier_keys = vector[
            utf8(b"name"),
            utf8(b"link"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];

        let capy_soldier_values = vector[
            utf8(b"{name}"),
            utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"capy vs. gnome"),
            utf8(b"https://capy-vs-gnome.xyz"),
            utf8(b"unk"),
        ];


        let publisher = package::claim(otw, ctx);

        // add gnomes to display
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


        // add gnome rider
        let display_gnome_rider = display::new_with_fields<GnomeRider>(
            &publisher, gnome_rider_keys, gnome_rider_values, ctx
        );

        display::update_version(&mut display_gnome_rider);


        // add gnome soldier
        let display_gnome_soldier = display::new_with_fields<GnomeSoldier>(
            &publisher, gnome_soldier_keys, gnome_soldier_values, ctx
        );

        display::update_version(&mut display_gnome_soldier);




        // add capybaras to display
        // add capy general
        let display_capy_general = display::new_with_fields<CapyGeneral>(
            &publisher, capy_general_keys, capy_general_values, ctx
        );

        display::update_version(&mut display_capy_general);


        // add capy monster
        let display_capy_monster = display::new_with_fields<CapyMonster>(
            &publisher, capy_monster_keys, capy_monster_values, ctx
        );

        display::update_version(&mut display_capy_monster);


        // add capy rider
        let display_capy_rider = display::new_with_fields<CapyRider>(
            &publisher, capy_rider_keys, capy_rider_values, ctx
        );

        display::update_version(&mut display_capy_rider);


        // add capy soldier
        let display_capy_soldier = display::new_with_fields<CapySoldier>(
            &publisher, capy_soldier_keys, capy_soldier_values, ctx
        );

        display::update_version(&mut display_capy_soldier);





        // transfer publisher
        transfer::public_transfer(publisher, tx_context::sender(ctx));
        // transfer character displays
        transfer::public_transfer(display_gnome_general, tx_context::sender(ctx));
        transfer::public_transfer(display_gnome_monster, tx_context::sender(ctx));
        transfer::public_transfer(display_gnome_rider, tx_context::sender(ctx));
        transfer::public_transfer(display_gnome_soldier, tx_context::sender(ctx));

        transfer::public_transfer(display_capy_general, tx_context::sender(ctx));
        transfer::public_transfer(display_capy_monster, tx_context::sender(ctx));
        transfer::public_transfer(display_capy_rider, tx_context::sender(ctx));
        transfer::public_transfer(display_capy_soldier, tx_context::sender(ctx));


    }




















    #[test_only]
    public fun init_for_testing(otw: RANDOM_NFTS, ctx: &mut TxContext) {
        init(otw, ctx);
    }





}