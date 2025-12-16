program main
   use mylib, only: show_precision, pass_real
   implicit none
   real :: x
   x = 3.14
   print *, "Main program"
   print *, "precision=", precision(x), "range=", range(x)
   call show_precision()
   ! WARN: This won't work if program/lib use different default real size.
   ! call pass_real(x)
end program main
