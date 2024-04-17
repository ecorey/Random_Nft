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














    struct RANDOM_NFTS has drop {}


    fun init(otw: RANDOM_NFTS, ctx: &mut TxContext) {



        let gnome_general_keys = vector[
            utf8(b""),
            utf8(b""),
            utf8(b""),
            utf8(b""),
            utf8(b""),
            utf8(b""),
        ];

        let gnome_general_values = vector[
            utf8(b""),
            utf8(b""),
            utf8(b""),
            utf8(b""),
            utf8(b""),
            utf8(b""),
        ];


        let publisher = package::claim(otw, ctx);

        let display = display::new_with_fields<GnomeGeneral>(
            &publisher, gnome_general_keys, gnome_general_values, ctx
        );


        display::update_version(&mut display);


        transfer::public_transfer(publisher, tx_context::sender(ctx));
        transfer::public_transfer(display, tx_context::sender(ctx));



    }




















    #[test_only]
    public fun init_for_testing(otw: RANDOM_NFTS, ctx: &mut TxContext) {
        init(otw, ctx);
    }





}