import sequtils

# constants
let PLAYER_GOAL = 200

type
    Game* =         object
    player_thirst*: int
    camel_torpor*:  int
    native_reach*:  int
    is_running*:    bool

type
    Action =     object
    identifier:  char
    description: string
    perform:     proc (game: Game)

var actions: seq[Action] = @[]

proc display_stats(game: Game) = 
    echo "Here are the numbers, boss!\n
          Your Thirst: $1\n
          Your camel's torpot: $2\n
          The native's distance: $3" % [game.player_thirst, 
                                        game.camel_torpor, 
                                        game.native_reach]

proc collect_action_idents(): seq[char] =
    result = map(actions, proc(ac: Action): char = ac.identifier )

proc is_proper_action(requested: char): bool = 
    any(collect_action_idents(), proc (ac: Action): bool = return ac == requested)

proc display_actions() =
    for action in actions:
        echo "$1: $2" % [action.identifier, action.description]
    stdout.write "Your Choice?: "

proc lookup_action(ident: char): Action = # should never return an invalid action, wont be called if action doesnt exist.
    result = filter[Action](actions, proc (x: Action): bool = x.ident == ident)

proc loop*(var game: Game) =
    display_actions()
    var resp = toLowerAscii(reacChar(stdin))
    while not is_proper_action(resp):
        stdout.write "Please enter a proper action: "
        resp = toLowerAscii(readChar(stdin))
    let selected_action = lookup_action(resp)
    selected_action.

proc add_action(ident: char, desc: string,
                action: proc (game: Game)) =
    actions.add Action(identifier: ident, 
                       desciption: desc, perform: action)
    
proc exit_game(var game: Game) =
    game.is_running = false
    echo "Thank you for playing!"


proc setup_actions() =
    add_action('Q', "Quit", proc(game: Game) = exit_game(game) )
    
proc main() =
    setup_actions()
    var m_game: Game = Game(player_thirst: 0,
                            camel_torpor: 0, 
                            native_reach: 20, 
                            is_running: true)
    while m_game.is_running:
        game.loop()