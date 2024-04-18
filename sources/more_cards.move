module capy_vs_gnome::more_cards {


    use sui::tx_context::{Self, TxContext};
    use sui::package::{Self, Publisher};
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::display::{Self, Display};
    use sui::event;
    use std::string::{utf8, String};

    #[test_only]
    friend capy_vs_gnome::more_card_tests;





    // ONE TIME USE POWER CARDS
    struct DivineShield has key, store {
        id: UID,
        name: String, 
        image_url: String,
    }






    // SPECIAL ACTIONS






    // STAT MODIFIERS





    // TACTICAL MOVES





    // STRATEGIC EFFECTS





    // UTILITY CARDS




    // when card is played it is lost, and the effect is applied to the player's character
    public fun use_divine_shield( divine_shield: DivineShield, ctx: &mut TxContext) {


        // One character is immune to all damage and effects for one turn. (Cost: 5 CP)


        let DivineShield {
            id,
            name: _,
            image_url: _,
        
        } = divine_shield; 

        object::delete(id);

    }








    struct MORE_CARDS has drop {}


    fun init(otw: MORE_CARDS, ctx: &mut TxContext) {


        // gnome general
        let divine_shield_keys = vector[
            utf8(b"name"),
            utf8(b"link"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];

        let divine_shield_values = vector[
            utf8(b"{name}"),
            utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"capy vs. gnome"),
            utf8(b"https://capy-vs-gnome.xyz"),
            utf8(b"unk"),
        ];


        let publisher = package::claim(otw, ctx);

        
        let display_divine_shield = display::new_with_fields<DivineShield>(
            &publisher, divine_shield_keys, divine_shield_values, ctx
        );

        display::update_version(&mut display_divine_shield);








        // transfer publisher
        transfer::public_transfer(publisher, tx_context::sender(ctx));
        // transfer character displays
        transfer::public_transfer(display_divine_shield, tx_context::sender(ctx));
       


    }




    fun mint_divine_shield(ctx: &mut TxContext) : DivineShield {
        let id = object::new(ctx);

        DivineShield {
            id: id,
            name: utf8(b"divine shield"),
            image_url: utf8(b"ipfs://divine_shield_image_url"),
        }
    }








    // delete functions for gnome warriors
    public fun delete_divine_shield(divine_shield: DivineShield) {
        let DivineShield { id, name: _, image_url: _ } = divine_shield;
        object::delete(id);
    }






    #[test_only]
    public fun init_for_testing(otw: MORE_CARDS, ctx: &mut TxContext) {
        init(otw, ctx);
    }





}