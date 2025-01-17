#include <graphics.h>
#include <iostream>
#include <cmath> // For round() function

using namespace std;

void drawLineDDA(int x1, int y1, int x2, int y2) {
    // Calculate differences
    int dx = x2 - x1;
    int dy = y2 - y1;

    // Determine the number of steps needed
    int steps = abs(dx) > abs(dy) ? abs(dx) : abs(dy);

    // Calculate increment values
    float xIncrement = dx / float(steps);
    float yIncrement = dy / float(steps);

    // Start drawing the line
    float x = x1;
    float y = y1;

    for (int i = 0; i <= steps; i++) {
        putpixel(round(x), round(y), WHITE); // Plot the pixel
        x += xIncrement; // Increment x
        y += yIncrement; // Increment y
    }
}

int main() {
    int gd = DETECT, gm;
    initgraph(&gd, &gm, "");

    // Input line endpoints
    int x1, y1, x2, y2;
    cout << "Enter the starting point (x1, y1): ";
    cin >> x1 >> y1;
    cout << "Enter the ending point (x2, y2): ";
    cin >> x2 >> y2;

    // Draw the line using DDA algorithm
    drawLineDDA(x1, y1, x2, y2);

    getch();
    closegraph();
    return 0;
}
