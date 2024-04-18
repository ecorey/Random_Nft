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




    // ----------------------------------------------
    // ONE TIME USE POWER CARDS 
    // ----------------------------------------------


    // DIVINE SHIELD *********************************
    struct DivineShield has key, store {
        id: UID,
        name: String, 
        image_url: String,
    }


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


    fun mint_divine_shield(ctx: &mut TxContext) : DivineShield {
        let id = object::new(ctx);

        DivineShield {
            id: id,
            name: utf8(b"divine shield"),
            image_url: utf8(b"ipfs://divine_shield_image_url"),
        }
    }


    
    public fun delete_divine_shield(divine_shield: DivineShield) {
        let DivineShield { id, name: _, image_url: _ } = divine_shield;
        object::delete(id);
    }



    // LAST STAND *********************************
    struct LastStand has key, store {
        id: UID,
        name: String, 
        image_url: String,
    }


    // when card is played it is lost, and the effect is applied to the player's character
    public fun use_last_stand( last_stand: LastStand, ctx: &mut TxContext) {


        // For one turn, your characters cannot be reduced below 1 health. (Cost: 5 CP)

        let LastStand {
            id,
            name: _,
            image_url: _,
        
        } = last_stand; 

        object::delete(id);

    }


    fun mint_last_stand(ctx: &mut TxContext) : LastStand {
        let id = object::new(ctx);

        LastStand {
            id: id,
            name: utf8(b"last stand"),
            image_url: utf8(b"ipfs://last_stand_image_url"),
        }
    }


    
    public fun delete_last_stand(last_stand: LastStand) {
        let LastStand { id, name: _, image_url: _ } = last_stand;
        object::delete(id);
    }




    // MASSIVE ONSLAUGHT *********************************
    struct MassiveOnslaught has key, store {
        id: UID,
        name: String, 
        image_url: String,
    }


    // when card is played it is lost, and the effect is applied to the player's character
    public fun use_massive_onslaught( massive_onslaught: MassiveOnslaught, ctx: &mut TxContext) {


        // For one turn, your characters cannot be reduced below 1 health. (Cost: 5 CP)

        let MassiveOnslaught {
            id,
            name: _,
            image_url: _,
        
        } = massive_onslaught; 

        object::delete(id);

    }


    fun mint_massive_onslaught(ctx: &mut TxContext) : MassiveOnslaught {
        let id = object::new(ctx);

        MassiveOnslaught {
            id: id,
            name: utf8(b"massive onslaught"),
            image_url: utf8(b"ipfs://massive_onslaught_image_url"),
        }
    }


    
    public fun delete_massive_onslaught(massive_onslaught: MassiveOnslaught) {
        let MassiveOnslaught { id, name: _, image_url: _ } = massive_onslaught;
        object::delete(id);
    }







    // ----------------------------------------------
    // SPECIAL ACTIONS
    // ----------------------------------------------

    // BATTLE CRY **************************************





    // DECISIVE STRIKE *********************************





    // SHIELD BASH *************************************











    // ----------------------------------------------
    // STAT MODIFIERS
    // ----------------------------------------------
    // BOOST ATTACK **************************************





    // FORTIFY DEFENSE *********************************





    // VITALITY SURGE ********************************









    // ----------------------------------------------
    // TACTICAL MOVES
    // ----------------------------------------------

    // AMBUSH **************************************





    // QUICK RETREAT *********************************





    // REINFORCEMENTS *********************************








    // ----------------------------------------------
    // STRATEGIC EFFECTS
    // ----------------------------------------------

    // PEACE TREATY ***********************************





    // SABOTAGE **************************************





    // WAR DRUMS *************************************










    // ----------------------------------------------
    // UTILITY CARDS
    // ----------------------------------------------

    // ESPIONAGE **************************************





    // REGROUP ***************************************





    // SCOUT *****************************************


    










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




    






    #[test_only]
    public fun init_for_testing(otw: MORE_CARDS, ctx: &mut TxContext) {
        init(otw, ctx);
    }





}