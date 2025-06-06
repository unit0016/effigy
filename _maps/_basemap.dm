//#define LOWMEMORYMODE //uncomment this to load centcom and runtime station and thats it.

#include "map_files\generic\CentCom.dmm"

#ifndef LOWMEMORYMODE
	#ifdef ALL_MAPS
		// TG Base Maps
		#include "map_files\debug\multiz.dmm"
		#include "map_files\debug\runtimestation.dmm"
		#include "map_files\IceBoxStation\IceBoxStation.dmm"
		#include "map_files\MetaStation\MetaStation.dmm"
		#include "map_files\Mining\Lavaland.dmm"
		#include "map_files\tramstation\tramstation.dmm"
		#include "map_files\NebulaStation\NebulaStation.dmm"
		// Effigy Maps
		#include "effigy\map_files\FoxHoleStation\foxholestation.dmm"
		#include "effigy\map_files\RimPoint\RimPoint.dmm"
		#include "effigy\map_files\SigmaOctantis\SigmaOctantis.dmm"
	#endif
	#ifdef ALL_TEMPLATES
		#include "templates.dm"
	#endif
#endif
