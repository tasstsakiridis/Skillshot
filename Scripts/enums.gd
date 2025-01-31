extends Node

enum MOVE_DIRECTION { Horizontal, Vertical }
enum ROTATION_DIRECTION { Clockwise = 1, AntiClockwise = -1 }
enum GAME_STATE { None, Loading, Playing, Fired, Won, Lost, Paused }
