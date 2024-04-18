module capy_vs_gnome::more_cards {


    use sui::tx_context::{Self, TxContext};
    use sui::package::{Self, Publisher};
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::display::{Self, Display};
    use sui::event;
    use std::string::{utf8, String};

    #[test_only]
    friend capy_vs_gnome::capy_vs_gnome_tests;



    // ONE TIME USE POWER CARDS
    struct Rando has key, store {
        id: UID,
        name: String, 
        image_url: String,
    }






    // SPECIAL ACTIONS






    // STAT MODIFIERS





    // TACTICAL MOVES





    // STRATEGIC EFFECTS





    // UTILITY CARDS














    struct MORE_CARDS has drop {}


    fun init(otw: MORE_CARDS, ctx: &mut TxContext) {


        // gnome general
        let rando_keys = vector[
            utf8(b"name"),
            utf8(b"link"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];

        let rando_values = vector[
            utf8(b"{name}"),
            utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"capy vs. gnome"),
            utf8(b"https://capy-vs-gnome.xyz"),
            utf8(b"unk"),
        ];


        let publisher = package::claim(otw, ctx);

        
        let display_rando = display::new_with_fields<Rando>(
            &publisher, rando_keys, rando_values, ctx
        );

        display::update_version(&mut display_rando);








        // transfer publisher
        transfer::public_transfer(publisher, tx_context::sender(ctx));
        // transfer character displays
        transfer::public_transfer(display_rando, tx_context::sender(ctx));
       


    }




    fun mint_rando(ctx: &mut TxContext) : Rando {
        let id = object::new(ctx);

        Rando {
            id: id,
            name: utf8(b"gnome general"),
            image_url: utf8(b"ipfs://gnome_general_image_url"),
        }
    }








    // delete functions for gnome warriors
    public fun delete_rando(gnome_general: Rando) {
        let Rando { id, name: _, image_url: _ } = gnome_general;
        object::delete(id);
    }






    #[test_only]
    public fun init_for_testing(otw: MORE_CARDS, ctx: &mut TxContext) {
        init(otw, ctx);
    }





}