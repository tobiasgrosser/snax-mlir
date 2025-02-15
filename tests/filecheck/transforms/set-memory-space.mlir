// RUN: ./compiler/snax-opt --split-input-file %s -p set-memory-space --print-op-generic | filecheck %s

"builtin.module"() ({
  "func.func"() <{function_type = (memref<64xi32>, memref<64xi32>, memref<64xi32>) -> (), sym_name = "simple_mult", sym_visibility = "public"}> ({
  ^bb0(%arg0: memref<64xi32>, %arg1: memref<64xi32>, %arg2: memref<64xi32>):
    "linalg.generic"(%arg0, %arg1, %arg2) <{indexing_maps = [affine_map<(d0) -> (d0)>, affine_map<(d0) -> (d0)>, affine_map<(d0) -> (d0)>], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: i32, %arg4: i32, %arg5: i32):
      %0 = "arith.muli"(%arg3, %arg4) : (i32, i32) -> i32
      "linalg.yield"(%0) : (i32) -> ()
    }) : (memref<64xi32>, memref<64xi32>, memref<64xi32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

//CHECK:      "builtin.module"() ({
//CHECK-NEXT:   "func.func"() <{"sym_name" = "simple_mult", "function_type" = (memref<64xi32, 0 : i32>, memref<64xi32, 0 : i32>, memref<64xi32, 0 : i32>) -> (), "sym_visibility" = "public"}> ({
//CHECK-NEXT:   ^0(%arg0 : memref<64xi32, 0 : i32>, %arg1 : memref<64xi32, 0 : i32>, %arg2 : memref<64xi32, 0 : i32>):
//CHECK-NEXT:     %0 = "memref.alloc"() <{"operandSegmentSizes" = array<i32: 0, 0>}> {"alignment" = 64 : i64} : () -> memref<64xi32, 1 : i32>
//CHECK-NEXT:     %1 = "memref.alloc"() <{"operandSegmentSizes" = array<i32: 0, 0>}> {"alignment" = 64 : i64} : () -> memref<64xi32, 1 : i32>
//CHECK-NEXT:     %2 = "memref.alloc"() <{"operandSegmentSizes" = array<i32: 0, 0>}> {"alignment" = 64 : i64} : () -> memref<64xi32, 1 : i32>
//CHECK-NEXT:     "memref.copy"(%arg0, %0) : (memref<64xi32, 0 : i32>, memref<64xi32, 1 : i32>) -> ()
//CHECK-NEXT:     "memref.copy"(%arg1, %1) : (memref<64xi32, 0 : i32>, memref<64xi32, 1 : i32>) -> ()
//CHECK-NEXT:     "linalg.generic"(%0, %1, %2) <{"indexing_maps" = [affine_map<(d0) -> (d0)>, affine_map<(d0) -> (d0)>, affine_map<(d0) -> (d0)>], "iterator_types" = [#linalg.iterator_type<parallel>], "operandSegmentSizes" = array<i32: 2, 1>}> ({
//CHECK-NEXT:     ^1(%arg3 : i32, %arg4 : i32, %arg5 : i32):
//CHECK-NEXT:       %3 = "arith.muli"(%arg3, %arg4) : (i32, i32) -> i32
//CHECK-NEXT:       "linalg.yield"(%3) : (i32) -> ()
//CHECK-NEXT:     }) : (memref<64xi32, 1 : i32>, memref<64xi32, 1 : i32>, memref<64xi32, 1 : i32>) -> ()
//CHECK-NEXT:     "memref.copy"(%2, %arg2) : (memref<64xi32, 1 : i32>, memref<64xi32, 0 : i32>) -> ()
//CHECK-NEXT:     "func.return"() : () -> ()
//CHECK-NEXT:   }) : () -> ()
//CHECK-NEXT: }) : () -> ()

// -----

"builtin.module"() ({
  "func.func"() <{function_type = (memref<64xi32>, memref<64xi32>, memref<64xi32>) -> (), sym_name = "simple_mult", sym_visibility = "public"}> ({
  ^bb0(%arg0: memref<64xi32>, %arg1: memref<64xi32>, %arg2: memref<64xi32>):
    "linalg.generic"(%arg0, %arg1, %arg2) <{indexing_maps = [affine_map<(d0) -> (d0)>, affine_map<(d0) -> (d0)>, affine_map<(d0) -> (d0)>], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: i32, %arg4: i32, %arg5: i32):
      %0 = "arith.muli"(%arg3, %arg4) : (i32, i32) -> i32
      "linalg.yield"(%0) : (i32) -> ()
    }) : (memref<64xi32>, memref<64xi32>, memref<64xi32>) -> ()
    "linalg.generic"(%arg0, %arg1, %arg2) <{indexing_maps = [affine_map<(d0) -> (d0)>, affine_map<(d0) -> (d0)>, affine_map<(d0) -> (d0)>], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: i32, %arg4: i32, %arg5: i32):
      %0 = "arith.muli"(%arg3, %arg4) : (i32, i32) -> i32
      "linalg.yield"(%0) : (i32) -> ()
    }) : (memref<64xi32>, memref<64xi32>, memref<64xi32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()


//CHECK:      "builtin.module"() ({
//CHECK-NEXT:   "func.func"() <{"sym_name" = "simple_mult", "function_type" = (memref<64xi32, 0 : i32>, memref<64xi32, 0 : i32>, memref<64xi32, 0 : i32>) -> (), "sym_visibility" = "public"}> ({
//CHECK-NEXT:   ^0(%arg0 : memref<64xi32, 0 : i32>, %arg1 : memref<64xi32, 0 : i32>, %arg2 : memref<64xi32, 0 : i32>):
//CHECK-NEXT:     %0 = "memref.alloc"() <{"operandSegmentSizes" = array<i32: 0, 0>}> {"alignment" = 64 : i64} : () -> memref<64xi32, 1 : i32>
//CHECK-NEXT:     %1 = "memref.alloc"() <{"operandSegmentSizes" = array<i32: 0, 0>}> {"alignment" = 64 : i64} : () -> memref<64xi32, 1 : i32>
//CHECK-NEXT:     %2 = "memref.alloc"() <{"operandSegmentSizes" = array<i32: 0, 0>}> {"alignment" = 64 : i64} : () -> memref<64xi32, 1 : i32>
//CHECK-NEXT:     "memref.copy"(%arg0, %0) : (memref<64xi32, 0 : i32>, memref<64xi32, 1 : i32>) -> ()
//CHECK-NEXT:     "memref.copy"(%arg1, %1) : (memref<64xi32, 0 : i32>, memref<64xi32, 1 : i32>) -> ()
//CHECK-NEXT:     "linalg.generic"(%0, %1, %2) <{"indexing_maps" = [affine_map<(d0) -> (d0)>, affine_map<(d0) -> (d0)>, affine_map<(d0) -> (d0)>], "iterator_types" = [#linalg.iterator_type<parallel>], "operandSegmentSizes" = array<i32: 2, 1>}> ({
//CHECK-NEXT:     ^1(%arg3 : i32, %arg4 : i32, %arg5 : i32):
//CHECK-NEXT:       %3 = "arith.muli"(%arg3, %arg4) : (i32, i32) -> i32
//CHECK-NEXT:       "linalg.yield"(%3) : (i32) -> ()
//CHECK-NEXT:     }) : (memref<64xi32, 1 : i32>, memref<64xi32, 1 : i32>, memref<64xi32, 1 : i32>) -> ()
//CHECK-NEXT:     "linalg.generic"(%0, %1, %2) <{"indexing_maps" = [affine_map<(d0) -> (d0)>, affine_map<(d0) -> (d0)>, affine_map<(d0) -> (d0)>], "iterator_types" = [#linalg.iterator_type<parallel>], "operandSegmentSizes" = array<i32: 2, 1>}> ({
//CHECK-NEXT:     ^2(%arg3_1 : i32, %arg4_1 : i32, %arg5_1 : i32):
//CHECK-NEXT:       %4 = "arith.muli"(%arg3_1, %arg4_1) : (i32, i32) -> i32
//CHECK-NEXT:       "linalg.yield"(%4) : (i32) -> ()
//CHECK-NEXT:     }) : (memref<64xi32, 1 : i32>, memref<64xi32, 1 : i32>, memref<64xi32, 1 : i32>) -> ()
//CHECK-NEXT:     "memref.copy"(%2, %arg2) : (memref<64xi32, 1 : i32>, memref<64xi32, 0 : i32>) -> ()
//CHECK-NEXT:     "func.return"() : () -> ()
//CHECK-NEXT:   }) : () -> ()
//CHECK-NEXT: }) : () -> ()
