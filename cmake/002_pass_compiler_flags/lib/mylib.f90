module mylib
   implicit none
   private
   public :: show_precision, pass_real
contains

   subroutine show_precision()
      real :: x
      x = 3.14
      print *, "mylib::show_precision()"
      print *, "precision=", precision(x), "range=", range(x)
   end subroutine show_precision

   subroutine pass_real(x)
      real, intent(in) :: x
   end subroutine pass_real

end module mylib
