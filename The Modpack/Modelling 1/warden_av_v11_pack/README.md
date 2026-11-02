# Warden AV–07 · V11 / Descending Front Lift

V11 refines V10 by lowering and sharpening the front lift pair to follow the cockpit/nose line. Six hybrid lift units remain; the middle and rear pairs retain their V10 placement.

## V11 front-lift alignment
- Rebuilt the fore ducts, dark inner throats and leading rims as true eight-facet octagons.
- Expanded their inner opening slightly to preserve rotor-tip clearance after changing the circular approximation to an octagon.
- Lowered the front outboard assemblies by 6.5 design units before roof compression.
- Lowered the inboard mount roots by 4 units and shifted them 6 units aft; the connecting structure now descends toward each fan instead of sitting horizontally beside the cockpit glass.
- Added fitted root fairings and descending frame edges below the side glazing.
- Moved 98 existing front-lift components together, preserving attached details.
- Cockpit length and glazing are unchanged. Added/reshaped meshes preserve the geometry in the model and viewer.

## Retained V10 frame enhancements
- Deeper overhung ballistic brows fitted to the actual windshield edges.
- Swept, rising shoulder collars creating a heavier armored silhouette around the troop body.
- Diagonal flank load ribs, shoulder vents and defined structural leading edges.
- Framed dorsal equipment area with longitudinal rails and mounted blocks; avionics and hatch retained.
- Extended prow cheek armor and a broad chisel-cut forward keel.
- Reinforced diagonal tail-root spars.
- Darker exhaust-shield/latch trim unifies the six lift assemblies.
- Existing service panels, sensors, refurbishment marks and wear remain; added armor obscures some details at particular viewing angles.

## Open
- `warden_av_v11.bbmodel`: editable Generic Blockbench model, embedded texture.
- `warden_v11_viewer.html`: self-contained textured WebGL orbit viewer. Drag to orbit, wheel/pinch to zoom, select preset views.
- `warden_v11_texture.png`: external 512 × 512 texture.
- `front.png`, `rear.png`, `side.png`, `mechanical.png`: renders of actual geometry.

## Six-unit hybrid layout
- Fore, middle and aft lift pairs, each with a real open twelve-facet annular duct and visible swept six-blade rotor.
- Middle pair positioned farther outboard; fore/aft units slightly raised for a staggered silhouette.
- Existing wing/pylon structure, bearing drums, actuator visuals, rotor stators, hubs, controller packs, rim latches and navigation markers duplicated with the full assemblies.
- New angular corner armor, forward nacelle inlet frames and splitter grilles echo the earlier rectangular thrusters.
- Rear vector housings, exhaust vanes and heat shields combine ducted lift and the older jet-pod visual language.
- Refurbished outer access covers, including a deliberately mismatched replacement panel.

## Changed central silhouette
- Warped the main body into a wider forward-shouldered, aft-tapering armored shape.
- Extended and narrowed the nose relative to the shoulder section.
- Added swept flank armor, defined diagonal structural edges and a deeper forward ventral keel.
- Preserved the detailed cockpit, sensors, roof equipment, ramp, markings, maintenance hardware and weathered textures. Some original details are now partially covered by the new shoulder armor or visible only at certain angles.
- Converted deformed cubes to mesh elements so the Blockbench model agrees with the geometry previews rather than retaining inaccurate axis-aligned cube bounds.

Overall envelope: approximately 102 wide × 37.54 high × 95.54 long model units. Y up; nose negative Z. At 16 units/block this is about 6.38 × 2.35 × 5.97 blocks. Scale to the seating plan and framework you choose; no actual cabin/seat capacity has been modeled.

## Data / checks
531 elements: 465 meshes + 66 cubes in 20 groups. Viewer triangulation: 9,884 triangles. 512 × 512 texture atlas.

Checked unique IDs/group membership, cube dimensions, mesh vertex references and UV bounds; inspected textured front/rear renders and checked viewer JavaScript syntax. Not opened/tested inside Blockbench, a browser runtime or Superb Warfare here.

## Art and compatibility limits
Static exterior art asset. Fans and vectoring hardware are not animated or engineering-validated. No troop interior, seats, weapons, collision, sounds, flight physics or SBW configuration. Assembled shells intentionally overlap; not a watertight manufacturing mesh. Opaque painted glass and non-emissive lights.

Generic format uses mesh geometry extensively. Cube-only Minecraft/GeckoLib/SBW exporters may need conversion/rebuilding. This is not a ready-to-install mod asset.

## Reference lineage
Original fan-made hybrid: MaxTac/Cyberpunk police-response identity, Avatar-style ducted VTOL transport arrangement, and AshVehicle/SBW military model cues. References inspected in the earlier passes include the official AshVehicle MH-60M, V-22 and RAH-66 gallery images, and an Avatar SA-2 Samson model photograph showing the ducted-fan structure.
- https://ashviper.github.io/AshVehicle-site/
- https://www.gambody.com/premium/sa-2-samson-avatar
No geometry/textures were extracted from these references. Not an official Cyberpunk, Avatar, Superb Warfare or AshVehicle asset.
