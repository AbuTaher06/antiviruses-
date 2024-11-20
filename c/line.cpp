#include <graphics.h>
#include <iostream>
#include <cmath> // For round() function

using namespace std;

void drawLineDirectEquation(int x1, int y1, int x2, int y2) {
    // Calculate slope (m) and y-intercept (c)
    float m = float(y2 - y1) / (x2 - x1); // Slope
    float c = y1 - m * x1;                // Intercept

    // Draw points along the line
    for (int x = x1; x <= x2; x++) {
        // Calculate corresponding y value using y = mx + c
        float y = m * x + c;
        putpixel(x, round(y), WHITE);
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

    // Ensure x1 < x2 for proper plotting
    if (x1 > x2) {
        swap(x1, x2);
        swap(y1, y2);
    }

    // Draw the line
    drawLineDirectEquation(x1, y1, x2, y2);

    getch();
    closegraph();
    return 0;
}
