#include "egpch.h"
#include "Application.h"

#include "Event/ApplicationEvent.h"
#include "Log.h"


namespace Engine {

	Application::Application()
	{
	}


	Application::~Application()
	{
	}

	void Application::Run()
	{
		WindowResizeEvent e(1280, 720);
		EG_TRACE(e.ToString());

		while (true);
	}
}