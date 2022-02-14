
from django.urls import path
from . import views

urlpatterns = [
    path('', views.getRoutes),
    path('allstudent/',views.getStudents),
    path('create/',views.createstudent),
    path('update/<str:pk>/',views.updatestudent),
    path('delete/<str:pk>',views.deletestudent),
    path('allstudent/<str:pk>/',views.getStudent),

]