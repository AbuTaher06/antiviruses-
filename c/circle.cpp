#include <graphics.h>
#include <iostream>
using namespace std;

// Function to plot points in all octants of the circle
void plotCirclePoints(int xc, int yc, int x, int y) {
    putpixel(xc + x, yc + y, WHITE); // Octant 1
    putpixel(xc - x, yc + y, WHITE); // Octant 2
    putpixel(xc + x, yc - y, WHITE); // Octant 3
    putpixel(xc - x, yc - y, WHITE); // Octant 4
    putpixel(xc + y, yc + x, WHITE); // Octant 5
    putpixel(xc - y, yc + x, WHITE); // Octant 6
    putpixel(xc + y, yc - x, WHITE); // Octant 7
    putpixel(xc - y, yc - x, WHITE); // Octant 8
}

// Bresenham's Circle Drawing Algorithm
void drawCircleBresenham(int xc, int yc, int r) {
    int x = 0, y = r;
    int d = 3 - 2 * r; // Initial decision parameter

    plotCirclePoints(xc, yc, x, y);

    while (x <= y) {
        x++;

        if (d < 0) {
            d += 4 * x + 6;
        } else {
            y--;
            d += 4 * (x - y) + 10;
        }

        plotCirclePoints(xc, yc, x, y);
    }
}

int main() {
    int gd = DETECT, gm;
    initgraph(&gd, &gm, "");

    // Input circle center and radius
    int xc, yc, r;
    cout << "Enter the center of the circle (xc, yc): ";
    cin >> xc >> yc;
    cout << "Enter the radius of the circle: ";
    cin >> r;

    // Draw the circle using Bresenham's algorithm
    drawCircleBresenham(xc, yc, r);

    getch();
    closegraph();
    return 0;
}
