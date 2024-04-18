module capy_vs_gnome::character_cards {


    use sui::tx_context::{Self, TxContext};
    use sui::package::{Self, Publisher};
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::display::{Self, Display};
    use sui::event;
    use std::string::{utf8, String};

    #[test_only]
    friend capy_vs_gnome::capy_vs_gnome_tests;



    struct GnomeGeneral has key, store {
        id: UID,
        name: String, 
        image_url: String,
        attack: u64,
        defense: u64,
        health: u64,
        cost: u64,
        ability_one: String,
        ability_two: String,
    }

    struct GnomeMonster has key, store {
        id: UID,
        name: String, 
        image_url: String,
        attack: u64,
        defense: u64,
        health: u64,
        cost: u64,
        ability: String,
    }

    struct GnomeRider has key, store {
        id: UID,
        name: String, 
        image_url: String,
        attack: u64,
        defense: u64,
        health: u64,
        cost: u64,
        ability: String,
    }

    struct GnomeSoldier has key, store {
        id: UID,
        name: String, 
        image_url: String,
        attack: u64,
        defense: u64,
        health: u64,
        cost: u64,
        ability: String,
    }







    struct CapyGeneral has key, store {
        id: UID,
        name: String, 
        image_url: String,
        attack: u64,
        defense: u64,
        health: u64,
        cost: u64,
        ability_one: String,
        ability_two: String,
    }

    struct CapyMonster has key, store {
        id: UID,
        name: String, 
        image_url: String,
        attack: u64,
        defense: u64,
        health: u64,
        cost: u64,
        ability: String,
    }

    struct CapyRider has key, store {
        id: UID,
        name: String, 
        image_url: String,
        attack: u64,
        defense: u64,
        health: u64,
        cost: u64,
        ability: String,
    }

    struct CapySoldier has key, store {
        id: UID,
        name: String, 
        image_url: String,
        attack: u64,
        defense: u64,
        health: u64,
        cost: u64,
        ability: String,
    }






    struct CHARACTER_CARDS has drop {}


    fun init(otw: CHARACTER_CARDS, ctx: &mut TxContext) {


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




    fun mint_gnome_general(ctx: &mut TxContext) : GnomeGeneral {
        let id = object::new(ctx);

        GnomeGeneral {
            id: id,
            name: utf8(b"gnome general"),
            image_url: utf8(b"ipfs://gnome_general_image_url"),
            attack: 3,
            defense: 4,
            health: 6,
            cost: 4,
            ability_one: utf8(b"Rally"),
            ability_two: utf8(b"Defensive Orders"),
        }
    }

    fun mint_gnome_monster(ctx: &mut TxContext) : GnomeMonster {
        let id = object::new(ctx);

        GnomeMonster {
            id: id,
            name: utf8(b"gnome monster"),
            image_url: utf8(b"ipfs://gnome_monster_image_url"),
            attack: 6,
            defense: 2,
            health: 5,
            cost: 5,
            ability: utf8(b"Fury Assault"),
        }
    }

    fun mint_gnome_rider(ctx: &mut TxContext) : GnomeRider {
        let id = object::new(ctx);

        GnomeRider {
            id: id,
            name: utf8(b"gnome rider"),
            image_url: utf8(b"ipfs://gnome_rider_image_url"),
            attack: 4,
            defense: 3,
            health: 4,
            cost: 3,
            ability: utf8(b"Lightning Strike"),
        }
    }

    fun mint_gnome_soldier(ctx: &mut TxContext) : GnomeSoldier {
        let id = object::new(ctx);

        GnomeSoldier {
            id: id,
            name: utf8(b"gnome soldier"),
            image_url: utf8(b"ipfs://gnome_soldier_image_url"),
            attack: 4,
            defense: 5,
            health: 5,
            cost: 3,
            ability: utf8(b"Shield Wall"),
        }
    }




    fun mint_capy_general(ctx: &mut TxContext) : CapyGeneral {
        let id = object::new(ctx);

        CapyGeneral {
            id: id,
            name: utf8(b"capy general"),
            image_url: utf8(b"ipfs://capy_general_image_url"),
            attack: 3,
            defense: 4,
            health: 6,
            cost: 4,
            ability_one: utf8(b"Rally"),
            ability_two: utf8(b"Defensive Orders"),
        }
    }

    fun mint_capy_monster(ctx: &mut TxContext) : CapyMonster {
        let id = object::new(ctx);

        CapyMonster {
            id: id,
            name: utf8(b"capy monster"),
            image_url: utf8(b"ipfs://capy_monster_image_url"),
            attack: 6,
            defense: 2,
            health: 5,
            cost: 5,
            ability: utf8(b"Fury Assault"),
        }
    }

    fun mint_capy_rider(ctx: &mut TxContext) : CapyRider {
        let id = object::new(ctx);

        CapyRider {
            id: id,
            name: utf8(b"capy rider"),
            image_url: utf8(b"ipfs://capy_rider_image_url"),
            attack: 4,
            defense: 3,
            health: 4,
            cost: 3,
            ability: utf8(b"Lightning Strike"),
        }
    }


    fun mint_capy_soldier(ctx: &mut TxContext) : CapySoldier {
        let id = object::new(ctx);

        CapySoldier {
            id: id,
            name: utf8(b"capy soldier"),
            image_url: utf8(b"ipfs://capy_soldier_image_url"),
            attack: 4,
            defense: 5,
            health: 5,
            cost: 3,
            ability: utf8(b"Shield Wall"),
        }
    }




    // MINT ARMIES
    // CHANGE OT MINT DECKS AFTER MORE CARDS IS COMPLETE
    public fun mint_gnome_army(ctx: &mut TxContext) : (GnomeGeneral, GnomeMonster, GnomeRider, GnomeSoldier) {
        let gnome_general = mint_gnome_general(ctx);
        let gnome_monster = mint_gnome_monster(ctx);
        let gnome_rider = mint_gnome_rider(ctx);
        let gnome_soldier = mint_gnome_soldier(ctx);

        (gnome_general, gnome_monster, gnome_rider, gnome_soldier)
    }


    public fun mint_capy_army(ctx: &mut TxContext) : (CapyGeneral, CapyMonster, CapyRider, CapySoldier) {
        let capy_general = mint_capy_general(ctx);
        let capy_monster = mint_capy_monster(ctx);
        let capy_rider = mint_capy_rider(ctx);
        let capy_soldier = mint_capy_soldier(ctx);

        (capy_general, capy_monster, capy_rider, capy_soldier)
    }






    // delete functions for gnome warriors
    public fun delete_gnome_general(gnome_general: GnomeGeneral) {
        let GnomeGeneral { id, name: _, image_url: _ , attack: _, defense: _, health: _, cost: _, ability_one: _, ability_two: _} = gnome_general;
        object::delete(id);
    }

    public fun delete_gnome_monster(gnome_monster: GnomeMonster) {
        let GnomeMonster { id, name: _, image_url: _, attack: _, defense: _, health: _, cost: _, ability: _ } = gnome_monster;
        object::delete(id);
    }

    public fun delete_gnome_rider(gnome_rider: GnomeRider) {
        let GnomeRider { id, name: _, image_url: _, attack: _, defense: _, health: _, cost: _, ability: _  } = gnome_rider;
        object::delete(id);
    }

    public fun delete_gnome_soldier(gnome_soldier: GnomeSoldier) {
        let GnomeSoldier { id, name: _, image_url: _ , attack: _, defense: _, health: _, cost: _, ability: _ } = gnome_soldier;
        object::delete(id);
    }


    // delete functions for capy warriors
    public fun delete_capy_general(capy_general: CapyGeneral) {
        let CapyGeneral { id, name: _, image_url: _, attack: _, defense: _, health: _, cost: _, ability_one: _, ability_two: _ } = capy_general;
        object::delete(id);
    }

    public fun delete_capy_monster(capy_monster: CapyMonster) {
        let CapyMonster { id, name: _, image_url: _, attack: _, defense: _, health: _, cost: _, ability: _  } = capy_monster;
        object::delete(id);
    }

    public fun delete_capy_rider(capy_rider: CapyRider) {
        let CapyRider { id, name: _, image_url: _, attack: _, defense: _, health: _, cost: _, ability: _  } = capy_rider;
        object::delete(id);
    }

    public fun delete_capy_soldier(capy_soldier: CapySoldier) {
        let CapySoldier { id, name: _, image_url: _, attack: _, defense: _, health: _, cost: _, ability: _  } = capy_soldier;
        object::delete(id);
    }





    #[test_only]
    public fun init_for_testing(otw: CHARACTER_CARDS, ctx: &mut TxContext) {
        init(otw, ctx);
    }





}