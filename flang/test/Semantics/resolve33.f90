! RUN: %B/test/Semantics/test_errors.sh %s %flang %t
! Derived type parameters
! C731 The same type-param-name shall not appear more than once in a given
! derived-type-stmt.

module m
  !ERROR: Duplicate type parameter name: 'a'
  type t1(a, b, a)
    integer, kind :: a
    integer(8), len :: b
  end type
  !ERROR: No definition found for type parameter 'b'
  type t2(a, b, c)
    integer, kind :: a
    integer, len :: c
  end type
  !ERROR: No definition found for type parameter 'b'
  type t3(a, b)
    integer, kind :: a
    integer :: b
  end type
  type t4(a)
    integer, kind :: a
    !ERROR: 'd' is not a type parameter of this derived type
    integer(8), len :: d
  end type
  type t5(a, b)
    integer, len :: a
    integer, len :: b
    !ERROR: Type parameter, component, or procedure binding 'a' already defined in this type
    integer, len :: a
  end type
  !ERROR: No definition found for type parameter 'k'
  !ERROR: No definition found for type parameter 'l'
  type :: t6(k, l)
    !ERROR: Must be a constant value
    character(kind=k, len=l) :: d3
  end type
  type(t6(2, 10)) :: x3
end module
