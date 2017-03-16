#if !defined(MAP_FILE)

        #include "map_files\debug\planettesting.dmm"

        #define MAP_FILE "planettesting.dmm"
        #define MAP_NAME "Test Map"

        #define MAP_TRANSITION_CONFIG	list(MAIN_STATION = SELFLOOPING)

#elif !defined(MAP_OVERRIDE)

	#warn a map has already been included, ignoring Test Map.

#endif