#if !defined(MAP_FILE)

        #include "map_files\_ARFS\ARFS Outpost.dmm"
        #include "map_files\ARFS\z02.dmm"
        #include "map_files\ARFS\z05.dmm"

        #define MAP_FILE "ARFS Outpost.dmm"
        #define MAP_NAME "ARFS Outpost"

        #define MAP_TRANSITION_CONFIG	list(MAIN_STATION = SELFLOOPING, CENTCOMM = SELFLOOPING, MINING = SELFLOOPING)

#elif !defined(MAP_OVERRIDE)

	#warn a map has already been included, ignoring ARFS Outpost.

#endif