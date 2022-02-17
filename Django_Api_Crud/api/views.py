# from django.http import JsonResponse
from rest_framework.decorators import api_view
from rest_framework.response import Response 
# Create your views here.
from . serilizer import studentSerilizer
from .models import student
@api_view(['GET'])
def getRoutes(request):
    routes=[
        {
            'EndPoint' : '/allstudent',
            'method':'GET'
        },

    ]
    return Response(routes)


@api_view(['GET'])
def getStudents(request):
    students=student.objects.all()
    serializer=studentSerilizer(students,many=True)
    return Response(serializer.data)

@api_view(['GET'])
def getStudent(request,pk):
    students=student.objects.get(id=pk)
    serializer=studentSerilizer(students,many=False)
    return Response(serializer.data)

@api_view(['POST'])
def createstudent(request):
    data=request.data

    student_data= student.objects.create(
        name=data['name'],
        rollnumber=data['rollnumber'],
        message=data['message']
    )
    serializer=studentSerilizer(student_data,many=False)
    return Response(serializer.data)

@api_view(['PUT'])
def updatestudent(request,pk):
    data=request.data
    studentdata=student.objects.get(id=pk)
    serializer=studentSerilizer(studentdata,data=request.data)
    if serializer.is_valid():
        serializer.save()
    
    return Response(serializer.data)

@api_view(['DELETE'])
def deletestudent(request,pk):
    studentdata=student.objects.get(id=pk)
    studentdata.delete()
    return Response('Student data is deleted')


